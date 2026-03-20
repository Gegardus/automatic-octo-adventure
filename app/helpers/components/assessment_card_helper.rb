# frozen_string_literal: true

module Components
  module AssessmentCardHelper
    def render_assessment_card(title:, description:, icon:, badges: [], active: false, opacity: false) # rubocop:disable Metrics/ParameterLists
      render('components/ui/assessment_card', title: title, icon:,
                                              description: description, badges: badges,
                                              active: active, opacity: opacity)
    end
  end
end
