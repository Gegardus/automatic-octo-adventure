# frozen_string_literal: true

# creates multiple skipped steps
class MultipleSkippedSteps
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :suv_application_id
  attribute :user_id
  attribute :step_name
  attribute :skip_for_team, :boolean, default: false
  attribute :module_name, :string
  attribute :steps_to_skip, array: true

  def save
    steps_to_skip.compact_blank.each do |step|
      clean_up_skipped_steps(step)
      SkippedStep.create!(
        step_name: step,
        suv_application_id: suv_application_id,
        user_id: user_id,
        module_name: module_name
      )
    end
    true
  end

  def clean_up_skipped_steps(step) # rubocop:disable Metrics/MethodLength
    skipped_for_application = SkippedStep.where(
      suv_application_id: suv_application_id,
      module_name: module_name,
      step_name: step
    )
    skipped_for_user = SkippedStep.where(
      user_id: user_id,
      module_name: module_name,
      step_name: step
    )

    scope = skipped_for_application.or(skipped_for_user)

    if suv_application_id
      skipped_for_application_users = SkippedStep.where(
        user: SuvApplication.find(suv_application_id).applicants,
        module_name: module_name,
        step_name: step
      )
      scope = scope.or(skipped_for_application_users)
    end

    scope.destroy_all
  end
end
