# frozen_string_literal: true

# Calculates overall item score based on slot value, ilvl, and quality for
# each item
module GearscoreCalculator
  class << self
    # Convenience method to avoid object initialization
    # @param items [Hash]
    # @return [Integer]
    def calculate(items)
      items.reduce(0) do |sum, (slot, item)|
        # Count main hand weapon as a two-hander if off-hand not present
        slot = :two_hand if slot.eql?(:main_hand) && !items.key?(:off_hand)
        sum + item_score(slot, item)
      end
    end

    private

    def item_score(slot, item)
      quality_sub, quality_div = quality_modifiers(item.level, item.quality)

      (((item.level - quality_sub) / quality_div) * SLOT_MODIFIERS.fetch(slot) * 1.8291).floor
    end

    def quality_modifiers(level, quality)
      return [level, 1] if quality.eql?(:poor)

      case level
      when 278..Float::INFINITY then [91.45, 0.65]
      when 121..277 then QUALITY_MODIFIERS.fetch(quality)
      else VANILLA_QUALITY_MODIFIERS.fetch(quality)
      end
    end
  end

  # Some slots are allocated a greater quantity of stats so this accounts
  # for that
  SLOT_MODIFIERS = {
    back: 0.5625,
    chest: 1,
    feet: 0.75,
    finger_1: 0.5625,
    finger_2: 0.5625,
    hands: 0.75,
    head: 1,
    legs: 1,
    main_hand: 1,
    neck: 0.5625,
    off_hand: 1,
    shoulder: 0.75,
    trinket_1: 0.5625,
    trinket_2: 0.5625,
    two_hand: 2,
    waist: 0.75,
    wrist: 0.5625,
  }.freeze

  QUALITY_MODIFIERS = {
    common: [73, 1],
    uncommon: [81.375, 0.8125],
    rare: [91.45, 0.65],
    epic: [91.45, 0.5],
    legendary: [91.45, 0.5],
    artifact: [81.375, 0.8125],
    heirloom: [81.375, 0.8125],
  }.freeze

  VANILLA_QUALITY_MODIFIERS = {
    common: [8, 2],
    uncommon: [0.75, 1.8],
    rare: [26, 1.2],
    epic: [26, 0.923],
    legendary: [26, 0.923],
    artifact: [81.375, 0.8125],
    heirloom: [81.375, 0.8125],
  }.freeze
end
