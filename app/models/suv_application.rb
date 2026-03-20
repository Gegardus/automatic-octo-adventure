# frozen_string_literal: true

# Everything to do with an applicants suv_application
class SuvApplication < ApplicationRecord
  has_many :applicants, class_name: 'User', dependent: :nullify

  has_one :inquiry, dependent: :destroy
  has_one :business_model, dependent: :destroy
  has_one :mentor_request, dependent: :destroy
  has_many :help_requests, dependent: :destroy
  has_many :skipped_steps, dependent: :destroy
  has_many :mentors, through: :mentor_request

  validates :team_name, uniqueness: true, presence: true
  attribute :team_name, :string

  has_one_attached :online_registration_document
  has_one_attached :bank_account_document

  after_initialize -> { build_inquiry unless inquiry }

  after_create -> { create_inquiry! unless inquiry.persisted? }

  def applicant_names
    applicants.map(&:full_name).join(', ')
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[team_name]
  end
end
