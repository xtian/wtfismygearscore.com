# frozen_string_literal: true
if Rails.env.production?
  require 'exception_notification/rails'
  require 'exception_notification/sidekiq'

  ExceptionNotification.configure do |config|
    # Ignore additional exception types.
    # ActiveRecord::RecordNotFound, Mongoid::Errors::DocumentNotFound,
    # AbstractController::ActionNotFound and ActionController::RoutingError are
    # already added.
    config.ignored_exceptions += %w(ActionController::ParameterMissing)

    config.add_notifier :slack,
                        backtrace_lines: 15,
                        webhook_url: Rails.application.secrets.slack_webhook_url
  end
end
