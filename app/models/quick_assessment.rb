# frozen_string_literal: true

# Encapsulates everything for a quick assessment
class QuickAssessment
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :applicant

  delegate :assertiveness_assessment_score, :responsiveness_assessment_score, to: :applicant

  def steps_for_applicant
    Steps.new(
      title: 'Quick assessment',
      all_steps: [
        QuickAssessmentSteps::IntroductionStep.new(applicant: applicant),
        QuickAssessmentSteps::AssertivenessAssessmentStep.new(applicant: applicant),
        QuickAssessmentSteps::ResponsivenessAssessmentStep.new(applicant: applicant),
        QuickAssessmentSteps::ResultsStep.new(applicant: applicant)
      ]
    )
  end

  def analytical?
    return true if analytical_driver? || analytical_amiable? || perfective?

    assertiveness_assessment_score < 5 && responsiveness_assessment_score < 5
  end

  def driver?
    return true if analytical_driver? || driver_expressive? || perfective?

    assertiveness_assessment_score > 5 && responsiveness_assessment_score < 5
  end

  def expressive?
    return true if amiable_expressive? || driver_expressive? || perfective?

    assertiveness_assessment_score > 5 && responsiveness_assessment_score > 5
  end

  def amiable?
    return true if analytical_amiable? || amiable_expressive? || perfective?

    assertiveness_assessment_score < 5 && responsiveness_assessment_score > 5
  end

  private

  def analytical_driver?
    assertiveness_assessment_score == 5 && responsiveness_assessment_score < 5
  end

  def amiable_expressive?
    assertiveness_assessment_score == 5 && responsiveness_assessment_score > 5
  end

  def analytical_amiable?
    assertiveness_assessment_score < 5 && responsiveness_assessment_score == 5
  end

  def driver_expressive?
    assertiveness_assessment_score > 5 && responsiveness_assessment_score == 5
  end

  def perfective?
    assertiveness_assessment_score == 5 && responsiveness_assessment_score == 5
  end
end
