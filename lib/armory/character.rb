# frozen_string_literal: true

require "armory/item"

class Armory
  # Simple wrapper around Armory character objects
  class Character
    attr_reader :api_id, :avg_ilvl, :class_name, :faction, :guild_name, :items, :level, :max_ilvl,
                :min_ilvl, :name, :realm, :region

    # rubocop:disable Metrics/AbcSize

    # @param region [String] Region is not included in response so it must be
    #   provided separately
    # @param profile_body [Hash]
    # @param equipment_body [Hash]
    def initialize(region:, profile_body:, equipment_body:)
      @api_id = profile_body.fetch("id")
      @avg_ilvl = profile_body.fetch("equipped_item_level")
      @class_name = CLASSES.fetch(profile_body.fetch("character_class").fetch("id") - 1)
      @faction = profile_body.fetch("faction").fetch("type").downcase
      @guild_name = profile_body.dig("guild", "name")
      @level = profile_body.fetch("level")
      @name = profile_body.fetch("name")
      @realm = profile_body.fetch("realm").fetch("name")
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

    # rubocop:enable Metrics/AbcSize
  end
end
