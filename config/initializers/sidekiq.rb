# frozen_string_literal: true
require 'sidekiq'

Sidekiq.default_worker_options = {
  unique: :until_and_while_executing,
  unique_args: ->(args) { args.first.except('job_id') }
}

SidekiqUniqueJobs.config.unique_args_enabled = true

Sidekiq.configure_server do |config|
  config.on(:startup) do
    unless Rails.env.test?
      MedianGearscoreUpdaterJob.perform_later
      RefreshStaleCharactersJob.perform_later
    end
  end
end
