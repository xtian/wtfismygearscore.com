# frozen_string_literal: true

class Armory
  # Simple wrapper around Armory API responses
  class Character
    attr_reader :avg_ilvl, :region

    # @param region [String] Region is not included in response so it must be
    #   provided separately
    # @param response_body [Hash]
    def initialize(region, response_body)
      @region = region.downcase
      @body = response_body
      process_items
    end

    # @!method name
    # @!method realm
    # @!method level
    %w(name realm level).each do |method_name|
      define_method method_name do
        body[method_name]
      end
    end

    # @return [String]
    def class_name
      CLASSES.fetch(body.fetch('class') - 1)
    end

    # @return [String]
    def faction
      FACTIONS.fetch(body.fetch('faction'))
    end

    # @return [String, nil]
    def guild_name
      body.dig('guild', 'name')
    end

    # @return [Hash]
    def items
      body.fetch('items')
    end

    # @return [Fixnum]
    def max_ilvl
      @_max_ilvl ||= ilvls.max
    end

    # @return [Fixnum]
    def min_ilvl
      @_min_ilvl ||= ilvls.min
    end

    private

    attr_reader :body, :ilvls

    def process_items
      body.fetch('items').delete 'averageItemLevel'
      @avg_ilvl = body.fetch('items').delete('averageItemLevelEquipped')

      @ilvls = body.fetch('items').freeze
        .reject { |k| %w(shirt tabard).include? k }
        .map { |_k, hash| hash.fetch('itemLevel') }
    end
  end
end
