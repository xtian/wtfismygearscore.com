# frozen_string_literal: true
class MedianGearscoreUpdaterJob < ApplicationJob
  def perform
    MedianGearscore.find_each(&:calculate)
  ensure
    self.class.set(wait_until: Date.tomorrow.midnight).perform_later
  end
end
