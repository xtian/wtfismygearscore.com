# frozen_string_literal: true
require 'securerandom'

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid

    def connect
      self.uuid = SecureRandom.uuid
      logger.add_tags 'ActionCable', uuid
    end
  end
end
