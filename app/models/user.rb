# frozen_string_literal: true

# All types of users in the system, admins, mentors or applicants
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_one :applicant_detail, dependent: :destroy
  has_many :applicant_skills, dependent: :destroy
  has_many :applicant_education_records, dependent: :destroy
  has_many :applicant_work_experiences, dependent: :destroy

  belongs_to :suv_application, optional: true
  has_one :inquiry, through: :suv_application
  has_one :business_model, through: :suv_application
  belongs_to :assertiveness_assessment, optional: true
  belongs_to :responsiveness_assessment, optional: true
  belongs_to :immigration_module, optional: true
  belongs_to :refining_your_idea_module, optional: true

  has_one :current_immigration_quiz, through: :immigration_module, class_name: 'ImmigrationQuiz'

  has_many :immigration_quizzes, through: :immigration_module

  attribute :invitations_count, default: 0

  ROLES = %w[admin applicant mentor].freeze

  enum role: ROLES.to_h { |type| [type, type] }, _default: 'applicant'

  validates :first_name, :last_name, :role, presence: true
  validates :phone, :date_of_birth, presence: true, if: :applicant?

  attribute :account_active, :boolean, default: true

  delegate :team_name, :mentor_request, :help_requests, to: :suv_application, allow_nil: true
  delegate :score, to: :assertiveness_assessment, prefix: true
  delegate :score, to: :responsiveness_assessment, prefix: true

  ROLES.each do |role|
    scope "active_#{role}".to_sym, -> { where(account_active: true, role: role) }
  end

  def active_for_authentication?
    super && account_active?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[first_name last_name email]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[suv_application]
  end
end
