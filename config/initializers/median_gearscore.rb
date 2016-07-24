# frozen_string_literal: true
Sidekiq.configure_server do |config|
  config.on(:startup) do
    MedianGearscoreUpdaterJob.perform_later unless Rails.env.test?
  end
end
