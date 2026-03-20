# frozen_string_literal: true

# Applicants request help
class HelpRequest < ApplicationRecord
  belongs_to :suv_application
  belongs_to :admin, optional: true, class_name: 'User'
  belongs_to :conversation

  validates :details, :module_name, :module_section, presence: true

  delegate :team_name, to: :suv_application

  before_validation :build_conversation, on: :create, if: -> { conversation.nil? }
end
