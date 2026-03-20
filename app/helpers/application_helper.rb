# frozen_string_literal: true

module ApplicationHelper # rubocop:disable Metrics/ModuleLength
  def module_step_path_for(application_module, step_name) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
    step_name = step_name.to_sym
    return if step_name.nil?

    case application_module
    when :pre_incubation
      inquiry_module_step_path_for(step_name)
    when :quick_assessment
      quick_assessment_module_step_path_for(step_name)
    when :immigration_module
      immigration_module_module_step_path_for(step_name)
    when :refining_your_idea
      refining_your_idea_modules_path(section: step_name)
    when :registration_documents
      registration_documents_steps_path(section: step_name)
    when :business_model
      business_models_path(section: step_name)
    end
  end

  def class_for_status_badge(status)
    # :nocov:
    case status # rubocop:disable Style/HashLikeCase
    when 'in_progress'
      'bg-blue-100 text-blue-800 dark:bg-blue-800/30 dark:text-blue-500'
    when 'approved'
      'bg-teal-100 text-teal-800 dark:bg-teal-800/30 dark:text-teal-500'
    when 'declined'
      'bg-red-100 text-red-800 dark:bg-red-800/30 dark:text-red-500'
    when 'submitted'
      'bg-yellow-100 text-yellow-800 dark:bg-yellow-800/30 dark:text-yellow-500'
    end
    # :nocov:
  end

  def render_nav_link(label:, path:, icon:) # rubocop:disable Metrics/MethodLength
    classes = 't group relative flex flex-col justify-center items-center rounded px-2 py-1.5 '
    classes += if request.fullpath.include?(path) ||
                  (request.fullpath.include?('decline_inquiries') && label == 'Applications') ||
                  modules_nav_link?(path: path)
                 'border-l-4 border-yellow-500 font-bold text-black'
               else
                 'text-gray-500'
               end

    content_tag(:li) do
      link_to path, class: classes do
        concat render_svg(icon)
        concat content_tag(:span, label, class: 'mt-1 navItemLabel')
      end
    end
  end

  def display_yes_no(boolean_value)
    boolean_value ? 'Yes' : 'No'
  end

  private

  def inquiry_module_step_path_for(step_name) # rubocop:disable Metrics/MethodLength
    case step_name
    when :applicant_detail
      inquiry_steps_applicant_detail_path
    when :your_interest
      edit_inquiry_steps_your_interest_path
    when :additional_information
      edit_inquiry_steps_additional_informations_path
    when :confirmation
      edit_inquiry_steps_confirmations_path
    else
      send("inquiry_steps_#{step_name}s_path")
    end
  end

  def quick_assessment_module_step_path_for(step_name)
    case step_name
    when :introduction
      new_quick_assessment_path
    when :assertiveness_assessment
      edit_assertiveness_assessments_path
    when :responsiveness_assessment
      edit_responsiveness_assessments_path
    when :results
      quick_assessment_path(current_user.id)
    end
  end

  def immigration_module_module_step_path_for(step_name)
    if %i[basic_info startup legal housing education helpful_tips].include?(step_name)
      immigration_modules_path(section: step_name)
    elsif step_name == :final_quiz
      new_immigration_quizzes_path
    end
  end

  def modules_nav_link?(path:)
    case path
    when '/modules'
      %w[inquiries inquiry_steps assessment modules quizzes applicant_mentor application_progress].any? do |substring|
        request.fullpath.include?(substring)
      end
    end
  end

  def status_badge_for_module(application_module_name, module_completed)
    if application_module_name == :pre_incubation && !current_user.inquiry.approved?
      inquiry_status_badge
    elsif module_completed
      render_status_badge(label: 'Completed', type: :success)
    end
  end

  # :nocov:
  def inquiry_status_badge
    if current_user.inquiry.submitted?
      render_status_badge(label: 'Awaiting approval', type: :warning)
    elsif current_user.inquiry.declined?
      render_status_badge(label: 'Declined', type: :danger) +
        link_to('View decline reason', edit_inquiry_steps_confirmations_path, class: 'text-xs text-blue-600')
    end
  end
  # :nocov:
end
