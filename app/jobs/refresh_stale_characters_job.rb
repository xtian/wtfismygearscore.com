# frozen_string_literal: true

class RefreshStaleCharactersJob < ApplicationJob
  def perform
    Character.where('updated_at <= ?', 1.month.ago).find_each do |character|
      CharacterUpdaterJob.perform_later(character)
    end
  ensure
    self.class.set(wait_until: 1.month.from_now).perform_later
  end
end
