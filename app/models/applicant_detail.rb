# frozen_string_literal: true

# Personal Applicant Detail
class ApplicantDetail < ApplicationRecord
  belongs_to :user

  MARITAL_STATUSES = %w[single married divorced widowed separated].freeze

  enum marital_status: MARITAL_STATUSES.to_h { |type| [type, type] }

  validates :pronouns, :country_of_origin, :country_of_application, :native_language,
            :tell_us_about_yourself, :current_address, :marital_status, presence: true

  has_one_attached :language_test_result_file
end
