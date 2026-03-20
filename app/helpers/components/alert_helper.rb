# frozen_string_literal: true

module Components
  module AlertHelper
    def render_alert(title:, description: nil, variant: :default, icon: true, &block) # rubocop:disable Metrics/MethodLength
      alert_classes = case variant.to_sym
                      when :error, :danger, :alert, :destructive
                        'Alert--danger'
                      when :success, :default, :notice
                        'Alert--success'
                      when :info
                        'Alert--info'
                      when :warning
                        # :nocov:
                        'Alert--warning'
                        # :nocov:
                      end
      content = (capture(&block) if block) || description
      render 'components/ui/alert', title:, content:, alert_classes:, variant:,
                                    icon:
    end
  end
end
