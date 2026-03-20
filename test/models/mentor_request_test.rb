# frozen_string_literal: true

require 'test_helper'

class MentorRequestTest < ActiveSupport::TestCase
  test 'creates a conversation on create' do
    request = assert_difference 'Conversation.count' do
      MentorRequest.create!(
        suv_application: suv_applications(:medical_diagnostic_clinic_application)
      )
    end

    assert request.conversation

    assert_no_difference 'Conversation.count' do
      request.update!(mentor_ids: users(:kali).id)
    end
  end

  test 'should not allow duplicate mentor request for the same suv application' do
    fitpal_application = suv_applications(:fitpal_application)
    off_boundaries_travel_application = suv_applications(:off_boundaries_travel_application)

    assert_invalid 'already has a mentor request', suv_application: fitpal_application
    assert_valid suv_application: off_boundaries_travel_application
  end
end
