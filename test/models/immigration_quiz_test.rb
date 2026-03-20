# frozen_string_literal: true

require 'test_helper'

class ImmigrationQuizTest < ActiveSupport::TestCase
  test '#passed' do
    subject.stub :score, 7 do
      assert_not subject.passed?
    end

    subject.stub :score, 8 do
      assert_predicate subject, :passed?
    end
  end
end
