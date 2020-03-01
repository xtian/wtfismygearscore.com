# typed: strict
# frozen_string_literal: true

require "sidekiq"

Sidekiq.default_worker_options = {
  lock: :until_and_while_executing,
  unique_args: ->(args) { args.first.except("job_id") },
}

Sidekiq.configure_server do |config|
  config.on(:startup) do
    unless Rails.env.test?
      MedianGearscoreUpdaterJob.perform_later
      RefreshStaleCharactersJob.perform_later
    end
  end
end
