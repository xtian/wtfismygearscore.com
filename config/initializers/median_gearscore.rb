# frozen_string_literal: true
Sidekiq.configure_client do
  Rails.application.config.after_initialize do
    MedianGearscoreUpdaterJob.perform_later unless Rails.env.test?
  end
end
