# frozen_string_literal: true
MedianGearscoreUpdaterJob.perform_later unless Rails.env.test?
