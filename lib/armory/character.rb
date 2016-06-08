# frozen_string_literal: true
class Armory
  class Character
    attr_reader :avg_ilvl, :region

    def initialize(region, response_body)
      @region = region.downcase
      @body = response_body
      process_items
    end

    %w(name realm level).each do |method_name|
      define_method method_name do
        body[method_name].freeze
      end
    end

    def class_name
      CLASSES[body["class"] - 1]
    end

    def faction
      FACTIONS[body["faction"]]
    end

    def guild_name
      body.dig("guild", "name")&.freeze
    end

    def items
      body["items"]
    end

    def max_ilvl
      @_max_ilvl ||= ilvls.max
    end

    def min_ilvl
      @_min_ilvl ||= ilvls.min
    end

    private

    attr_reader :body, :ilvls

    def process_items
      body["items"].delete "averageItemLevel"
      @avg_ilvl = body["items"].delete("averageItemLevelEquipped")

      @ilvls = body["items"].freeze
        .reject { |k| %w(shirt tabard).include? k }
        .map { |_k, hash| hash["itemLevel"] }
    end
  end
end
