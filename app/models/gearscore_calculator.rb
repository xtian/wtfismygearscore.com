# typed: true
# frozen_string_literal: true

# Calculates overall item score based on slot value, ilvl, and quality for
# each item
class GearscoreCalculator
  # @param items [Hash]
  def initialize(items)
    @items = items
  end

  # Convenience method to avoid object initialization
  # @param items [Hash]
  # @return [Integer]
  def self.calculate(items)
    new(items).calculate
  end

  # @return [Integer] gearscore for given items hash
  def calculate
    @_calculate ||= items.reduce(0) do |sum, (slot, hash)|
      # Count main hand weapon as a two-hander if off-hand not present
      slot = "twoHand" if slot.eql?("mainHand") && !items.key?("offHand")
      sum + Item.new(slot, hash).score
    end
  end

  private

  attr_reader :items

  class Item
    # @param slot [String]
    # @param hash [Hash]
    def initialize(slot, hash)
      @slot = slot
      @ilvl = hash["itemLevel"]
      @quality = hash["quality"]
    end

    # @return [Integer]
    def score
      (((ilvl - quality_modifier[0]) / quality_modifier[1]) *
       SLOT_MODIFIERS[slot] *
       1.8291).floor
    end

    private

    attr_reader :ilvl, :quality, :slot

    def quality_modifier
      @_quality_modifier ||= begin
          return [ilvl, 1] if quality.zero?

          case ilvl
          when 278..inf then [91.45, 0.65]
          when 121..277 then QUALITY_MODIFIERS[quality]
          else VANILLA_QUALITY_MODIFIERS[quality]
          end
        end
    end

    def inf
      Float::INFINITY
    end
  end

  # Some slots are allocated a greater quantity of stats so this accounts
  # for that
  SLOT_MODIFIERS = {
    "back" => 0.5625,
    "chest" => 1,
    "feet" => 0.75,
    "finger1" => 0.5625,
    "finger2" => 0.5625,
    "hands" => 0.75,
    "head" => 1,
    "legs" => 1,
    "mainHand" => 1,
    "neck" => 0.5625,
    "offHand" => 1,
    "shirt" => 0,
    "shoulder" => 0.75,
    "tabard" => 0,
    "trinket1" => 0.5625,
    "trinket2" => 0.5625,
    "twoHand" => 2,
    "waist" => 0.75,
    "wrist" => 0.5625,
  }.freeze

  QUALITY_MODIFIERS = [
    nil,
    [73, 1],
    [81.375, 0.8125],
    [91.45, 0.65],
    [91.45, 0.5],
    [91.45, 0.5],
    [81.375, 0.8125],
    [81.375, 0.8125],
  ].map(&:freeze).freeze

  VANILLA_QUALITY_MODIFIERS = [
    nil,
    [8, 2],
    [0.75, 1.8],
    [26, 1.2],
    [26, 0.923],
    [26, 0.923],
    [81.375, 0.8125],
    [81.375, 0.8125],
  ].map(&:freeze).freeze
end
