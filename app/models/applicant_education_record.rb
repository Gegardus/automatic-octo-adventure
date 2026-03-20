# frozen_string_literal: true

# this model captures the education of the applicant
class ApplicantEducationRecord < ApplicationRecord
  belongs_to :user

  validates :degree_type, :institution_name, :concentration,
            :start_date, :end_date, presence: true

  attribute :graduated, :boolean
end
