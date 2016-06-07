# frozen_string_literal: true
class MedianGearscoreUpdaterJob < ApplicationJob
  def perform
    Character.group(:level).count.keys.each do |level|
      MedianGearscore.find_or_initialize_by(level: level).calculate
    end
  ensure
    self.class.set(wait_until: Date.tomorrow.midnight).perform_later
  end
end
