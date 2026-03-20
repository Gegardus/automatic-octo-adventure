# frozen_string_literal: true

# encapsulates all work experience for an applicant user
class ApplicantWorkExperience < ApplicationRecord
  belongs_to :user

  validates :company, :job_title, :responsibilities, :tenure, :location, presence: true
end
