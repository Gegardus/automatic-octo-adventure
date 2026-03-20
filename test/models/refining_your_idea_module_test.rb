# frozen_string_literal: true

require 'test_helper'

class RefiningYourIdeaModuleTest < ActiveSupport::TestCase
  test 'validations' do # rubocop:disable Metrics/BlockLength
    bob = users(:bob)

    bob.update!(refining_your_idea_module: RefiningYourIdeaModule.create!)

    self.subject = bob.refining_your_idea_module

    subject.current_step = 'your_idea'

    RefiningYourIdeaModule::YOUR_IDEA_STEP_ATTRIBUTES.each do |attr|
      assert_invalid "can't be blank", "#{attr}": nil
      subject.send("#{attr}=", 'some value')
    end

    assert_predicate subject, :valid?

    subject.current_step = 'mission'

    assert_invalid "can't be blank", mission_statement: nil

    subject.mission_statement = 'some value'

    subject.current_step = 'vision'

    assert_invalid "can't be blank", vision_statement: nil

    subject.vision_statement = 'some value'

    subject.current_step = 'values'

    assert_invalid "can't be blank", values: nil

    subject.values = 'some value'

    subject.current_step = 'value_proposition'

    assert_invalid "can't be blank", value_proposition: nil

    subject.value_proposition = 'some value'

    subject.current_step = 'goals'

    RefiningYourIdeaModule::REQUIRED_GOALS_STEP_ATTRIBUTES.each do |attr|
      assert_invalid "can't be blank", "#{attr}": nil
      subject.send("#{attr}=", 'some value')
    end

    assert_predicate subject, :goals_step_completed?

    assert_predicate subject, :completed?
  end

  test 'length validations' do
    subject = RefiningYourIdeaModule.new(idea_description: 'a' * 601)

    assert_not subject.valid?
    assert_invalid 'is too long (maximum is 600 characters)', idea_description: 'a' * 601

    %i[personal_passion target_audience product_service_address market_gaps potential_user_feedback
       technical_financial_feasibility scalability flexibility].each do |attr|
      subject.update(attr => 'a' * 71)

      assert_not subject.valid?
      assert_invalid 'is too long (maximum is 70 characters)', "#{attr}": 'a' * 71
    end

    %i[mission_statement vision_statement value_proposition].each do |attr|
      subject.update(attr => 'a' * 301)

      assert_not subject.valid?
      assert_invalid 'is too long (maximum is 300 characters)', "#{attr}": 'a' * 301
    end
  end
end
