# frozen_string_literal: true

# encapsulates everything needed to make a SUV inquiry
class Inquiry < ApplicationRecord
  belongs_to :suv_application

  has_many :applicants, through: :suv_application

  validates :reason_for_interest, length: { maximum: 1200 }
  validates :where_did_you_hear_about_us, length: { maximum: 1200 }
  validates :startup_location, length: { maximum: 1200 }
  validates :other_business_industry, presence: true, if: :other_business_industry?
  validates :decline_reason, presence: true, if: :declined?

  validate :must_be_ready_to_submit_before_submitting
  validate :validate_status_transition
  validate :length_of_multi_selects_less_than_five

  attribute :submission_confirmed, :boolean, default: false
  attribute :company_founder, :boolean, default: false
  attribute :existing_business_idea, :boolean, default: false

  validates :submission_confirmed, :submission_date, :submission_full_name, presence: true, if: :submitted?

  attribute :area_of_expertise, :string, array: true, default: -> { [] }
  attribute :which_industries_excite_you, :string, array: true, default: -> { [] }

  delegate :team_name, to: :suv_application
  before_save :remove_decline_reason_on_submission

  STATUSES = %w[in_progress submitted approved declined].freeze
  BUSINESS_STAGES = %w[idea prototype mvp pilot launch other].freeze

  enum status: STATUSES.to_h { |type| [type, type] }, _default: 'in_progress'

  def ready_to_submit?
    applicants.all? do |applicant|
      pre_incubation_steps = ApplicationModules.new(applicant: applicant).pre_incubation_steps.all_steps

      pre_incubation_steps.reject { |step| step.step_name == :confirmation }.all?(&:completed?)
    end
  end

  def other_business_industry?
    business_industry&.downcase&.include?('other')
  end

  private

  def must_be_ready_to_submit_before_submitting
    return if !submitted? || ready_to_submit?

    return unless submission_confirmed?

    return if submission_date.nil? || submission_full_name.blank?

    errors.add(:base, 'All applicants must complete applicant specific steps before submitting')
  end

  def validate_status_transition
    return if %w[approved declined].exclude?(status)
    return if status_was == 'submitted'

    errors.add(:status, 'can only be set to approved or declined if the previous status was submitted')
  end

  def length_of_multi_selects_less_than_five
    if area_of_expertise.compact_blank.size > 5
      errors.add(:area_of_expertise, 'cannot be more than 5 choices.')
    end

    return unless which_industries_excite_you.compact_blank.size > 5

    errors.add(:which_industries_excite_you, 'cannot be more than 5 choices.')
  end

  def remove_decline_reason_on_submission
    self.decline_reason = nil unless declined?
  end
end
