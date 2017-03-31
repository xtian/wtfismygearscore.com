# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # rubocop:disable Style/AndOr
  def upsert!
    upsert or raise ActiveRecord::RecordInvalid
  end
  # rubocop:enable Style/AndOr
end
