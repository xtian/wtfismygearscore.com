# frozen_string_literal: true

class MedianGearscoreUpdaterJob < ApplicationJob
  # Triggers a median gearscore calculation for each distinct character level
  # in the DB. Afterwards, re-enqueues self for following midnight.
  # @return void
  def perform
    Character.group(:level).count.keys.each do |level|
      MedianGearscore.find_or_initialize_by(level: level).calculate
    end
  ensure
    self.class.set(wait_until: Date.tomorrow.midnight).perform_later
  end
end
