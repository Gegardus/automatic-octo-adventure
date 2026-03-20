# frozen_string_literal: true

# Mapping between mentor requests and mentors
class MentorRequestMentor < ApplicationRecord
  belongs_to :mentor_request
  belongs_to :mentor, optional: true, class_name: 'User'
end
