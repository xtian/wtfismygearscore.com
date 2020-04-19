# typed: false
# frozen_string_literal: true

require "armory/item"
require "date"

class Armory
  # Simple wrapper around Armory character objects
  class Character
    attr_reader :avg_ilvl, :class_name, :faction, :guild_name, :items, :last_modified, :level,
                :max_ilvl, :min_ilvl, :name, :realm, :region

    # @param region [String] Region is not included in response so it must be
    #   provided separately
    # @param last_modified [String]
    # @param character_body [Hash]
    # @param equipment_body [Hash]
    def initialize(region:, last_modified:, character_body:, equipment_body:)
      @avg_ilvl = character_body.fetch("equipped_item_level")
      @class_name = CLASSES.fetch(character_body.fetch("character_class").fetch("id") - 1)
      @faction = character_body.fetch("faction").fetch("type").downcase
      @guild_name = character_body.dig("guild", "name")
      @last_modified = DateTime.parse(last_modified).to_time.utc
      @level = character_body.fetch("level")
      @name = character_body.fetch("name")
      @realm = character_body.fetch("realm").fetch("name")
      @region = region.downcase

      @items = equipment_body
        .fetch("equipped_items")
        .reject { |item| %w[SHIRT TABARD].include?(item.fetch("slot").fetch("type")) }
        .map { |item| Item.new(item) }
        .each_with_object({}) { |item, hash| hash[item.slot] = item }
        .freeze

      ilvls = @items
        .map { |_slot, item| item.level }
        .tap { |list| list << 0 if list.empty? }

      @max_ilvl = ilvls.max
      @min_ilvl = ilvls.min
    end
  end
end
