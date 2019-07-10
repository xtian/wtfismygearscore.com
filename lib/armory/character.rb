# typed: false
# frozen_string_literal: true

class Armory
  # Simple wrapper around Armory character objects
  class Character
    attr_reader :avg_ilvl, :region

    # @param region [String] Region is not included in response so it must be
    #   provided separately
    # @param response_body [Hash]
    def initialize(region, response_body)
      @region = region.downcase
      @avg_ilvl = response_body.fetch('items').delete('averageItemLevelEquipped') { 0 }

      response_body.fetch('items').delete 'averageItemLevel'
      response_body.fetch('items').freeze
      @body = response_body
    end

    # @!method name
    # @!method realm
    # @!method level
    %w[name realm level].each do |method_name|
      define_method method_name do
        body.fetch(method_name)
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

    def last_modified
      @_last_modified ||= Time.at(body.fetch('lastModified') / 1000).utc
    end

    # @return [Integer]
    def max_ilvl
      @_max_ilvl ||= ilvls.max
    end

    # @return [Integer]
    def min_ilvl
      @_min_ilvl ||= ilvls.min
    end

    private

    attr_reader :body

    def ilvls
      @_ilvls ||= body.fetch('items')
        .without('shirt', 'tabard')
        .map { |_k, hash| hash.fetch('itemLevel') }
        .tap { |ilvls| ilvls << 0 if ilvls.empty? }
    end
  end
end
