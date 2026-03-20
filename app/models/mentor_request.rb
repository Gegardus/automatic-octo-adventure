# frozen_string_literal: true

# Applicant request for a mentor
class MentorRequest < ApplicationRecord
  belongs_to :suv_application
  belongs_to :conversation

  has_many :mentor_request_mentors, dependent: :destroy
  has_many :mentors, through: :mentor_request_mentors

  delegate :team_name, to: :suv_application

  before_validation :build_conversation, on: :create, if: -> { conversation.nil? }

  validate :mentor_request_does_not_exist_for_suv_application

  private

  def mentor_request_does_not_exist_for_suv_application
    return if MentorRequest.where(suv_application_id: suv_application_id)
                           .where.not(id: id)
                           .none?

    errors.add(:suv_application, 'already has a mentor request')
  end
end
