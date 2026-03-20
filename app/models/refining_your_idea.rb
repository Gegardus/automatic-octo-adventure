# frozen_string_literal: true

# Encapsulates pages for refining business ideas and strategies
class RefiningYourIdea
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :applicant

  def steps_for_applicant # rubocop:disable Metrics/MethodLength
    Steps.new(
      title: 'Module 2: Refine Your Idea',
      all_steps: [
        RefiningYourIdeaSteps::YourIdeaStep.new(applicant: applicant),
        RefiningYourIdeaSteps::MissionStep.new(applicant: applicant),
        RefiningYourIdeaSteps::VisionStep.new(applicant: applicant),
        RefiningYourIdeaSteps::ValuesStep.new(applicant: applicant),
        RefiningYourIdeaSteps::ValuePropositionStep.new(applicant: applicant),
        RefiningYourIdeaSteps::GoalsStep.new(applicant: applicant)
      ]
    )
  end
end
