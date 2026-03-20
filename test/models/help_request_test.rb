# frozen_string_literal: true

require 'test_helper'

class HelpRequestTest < ActiveSupport::TestCase
  test 'validations' do
    assert_invalid "can't be blank", details: nil

    assert_valid details: 'Free tax help guidance.'
  end

  test 'creates a conversation on create' do
    request = assert_difference 'Conversation.count' do
      HelpRequest.create!(
        suv_application: suv_applications(:medical_diagnostic_clinic_application),
        details: 'Consultation on tax code',
        module_name: 'Quick assessment',
        module_section: 'Introduction'
      )
    end

    assert request.conversation

    assert_no_difference 'Conversation.count' do
      request.update!(admin: users(:dom))
    end
  end
end
