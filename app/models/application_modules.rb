# frozen_string_literal: true

# All application modules
class ApplicationModules
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :applicant

  delegate :assertiveness_assessment, :responsiveness_assessment, :immigration_module, :refining_your_idea_module,
           :inquiry, :suv_application, to: :applicant

  delegate :online_registration_document, :bank_account_document, :business_model, to: :suv_application

  MODULES = %i[pre_incubation quick_assessment immigration_module refining_your_idea
               registration_documents].freeze

  def pre_incubation_steps
    PreIncubation.new(applicant: applicant).steps_for_applicant
  end

  def quick_assessment_steps
    QuickAssessment.new(applicant: applicant).steps_for_applicant
  end

  def immigration_module_steps
    Immigration.new(applicant: applicant).steps_for_applicant
  end

  def refining_your_idea_steps
    RefiningYourIdea.new(applicant: applicant).steps_for_applicant
  end

  def registration_documents_steps
    RegistrationDocuments.new(applicant: applicant).steps_for_applicant
  end

  def business_model_steps
    BusinessModel.new(applicant: applicant).steps_for_applicant
  end

  def self.steps_for_module(module_name)
    new(applicant: User.new).send("#{module_name}_steps")
  end

  def module_active?(step)
    case step
    when *MODULES
      step_index = MODULES.index(step)

      return !send("#{step}_steps").completed? if step_index.zero?

      previous_step_complete = send("#{MODULES[step_index - 1]}_steps").completed?
      current_step_not_complete = !send("#{step}_steps").completed?

      previous_step_complete && current_step_not_complete
    end
  end

  def progress_percentage
    compluted_modules_count = MODULES.map do |mod|
      send("#{mod}_steps").completed?
    end.count(true)

    ((compluted_modules_count.to_d / 14) * 100).to_i
  end
end
