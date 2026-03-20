# frozen_string_literal: true

# Conversation for other models
class Conversation < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_one :mentor_request, dependent: :destroy
  has_one :help_request, dependent: :destroy

  def can_user_manage?(user)
    !user.applicant? || (mentor_request || help_request).suv_application.applicants.include?(user)
  end
end
