# typed: false
# frozen_string_literal: true

class Armory
  # Simple wrapper around Armory item objects
  class Item
    attr_reader :level, :quality, :slot

    def initialize(item_body)
      @level = item_body.fetch("level").fetch("value")
      @quality = QUALITIES.fetch(item_body.fetch("quality").fetch("type"))
      @slot = SLOTS.fetch(item_body.fetch("slot").fetch("type"))
    end

    QUALITIES = {
      "POOR" => :poor,
      "COMMON" => :common,
      "UNCOMMON" => :uncommon,
      "RARE" => :rare,
      "EPIC" => :epic,
      "LEGENDARY" => :legendary,
      "ARTIFACT" => :artifact,
      "HEIRLOOM" => :heirloom,
    }.freeze

    SLOTS = {
      "BACK" => :back,
      "CHEST" => :chest,
      "FEET" => :feet,
      "FINGER_1" => :finger_1,
      "FINGER_2" => :finger_2,
      "HANDS" => :hands,
      "HEAD" => :head,
      "LEGS" => :legs,
      "MAIN_HAND" => :main_hand,
      "NECK" => :neck,
      "OFF_HAND" => :off_hand,
      "SHOULDER" => :shoulder,
      "TRINKET_1" => :trinket_1,
      "TRINKET_2" => :trinket_2,
      "TWO_HAND" => :two_hand,
      "WAIST" => :waist,
      "WRIST" => :wrist,
    }.freeze
  end
end
