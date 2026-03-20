# frozen_string_literal: true

require 'test_helper'

class RefiningYourIdeaModulesControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    given_signed_in_as :bob

    get refining_your_idea_module_path(section: 'mission')

    assert_response :success

    assert_page_header 'Module 2: Refine Your Idea'

    assert_form url: refining_your_idea_module_path(section: 'mission')
  end

  test '#show redirects to modules when next step is nil and all steps are skipped or completed' do
    given_signed_in_as :jim

    SkippedStep.create!(
      suv_application: users(:jim).suv_application,
      step_name: :goals,
      module_name: 'refining_your_idea_module'
    )

    get refining_your_idea_module_path(section: 'goals')

    assert_redirected_to modules_path
  end

  test '#update' do
    bob = given_signed_in_as :bob

    bob.update!(refining_your_idea_module: RefiningYourIdeaModule.create!)

    patch refining_your_idea_module_path(section: 'your_idea'), params: {
      refining_your_idea_module: your_idea_params
    }

    assert_redirected_to refining_your_idea_modules_path(section: 'mission')
  end

  test '#update fails' do
    bob = given_signed_in_as :bob

    bob.update!(refining_your_idea_module: RefiningYourIdeaModule.create!)

    patch refining_your_idea_module_path(section: 'your_idea'), params: {
      refining_your_idea_module: your_idea_params.merge(
        idea_description: nil
      )
    }

    assert_response :unprocessable_entity

    assert_danger_alert "Idea description can't be blank"
  end

  private

  def your_idea_params
    RefiningYourIdeaModule::YOUR_IDEA_STEP_ATTRIBUTES.index_with do
      'some value'
    end
  end
end
