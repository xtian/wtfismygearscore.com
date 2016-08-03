# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid

    # @return [void]
    def connect
      self.uuid = cookies.signed[:uuid]
      logger.add_tags 'ActionCable', uuid
    end
  end
end
