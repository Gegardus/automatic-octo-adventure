# frozen_string_literal: true

require 'application_system_test_case'

class ImmigrationQuizzesTest < ApplicationSystemTestCase
  test 'Answer final quiz questions' do
    # TODO: add one fixture
    # Given i am an applicant
    given_signed_in_as :jim
    User.stub_any_instance :assertiveness_assessment, true do
      User.stub_any_instance :responsiveness_assessment, true do
        visit root_path

        click_link 'Modules'

        # When i read some details about Canada
        # And complete final quiz
        complete_immigration_module

        # Then the immigration is submitted
        assert_immigration_submitted
      end
    end
  end
end
