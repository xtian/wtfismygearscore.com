# frozen_string_literal: true
class Character < ApplicationRecord
  enum class_name: CLASSES
  enum faction: FACTIONS
  enum region: VALID_REGIONS_WITH_REALM

  has_many :comments, -> { order(created_at: :desc) }

  validates :class_name, :level, :name, :realm, :region, :score, presence: true
  validates :level, numericality: { only_integer: true, greater_than: 0 }
  validates :score, numericality: { only_integer: true }

  validates :avg_ilvl, :max_ilvl, :min_ilvl,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true

  # @return [Fixnum]
  def comments_count
    @_comments_count ||= comments.count
  end

  # @param params [Hash]
  # @return [Comment]
  def create_comment(params)
    comments.create(params)
  end

  # @return [Float] difference between character's score and median for
  #   their level
  def median_difference
    @_median_difference ||= begin
      median_score = MedianGearscore.find_or_initialize_by(level: level).median_score
      score - median_score
    end
  end

  # @param character [Armory::Character] armory data
  # @param score [Fixnum] character's gearscore
  # @return void
  def update_from_armory(character, score)
    fields = %i(avg_ilvl class_name faction guild_name level max_ilvl min_ilvl name realm)
      .each_with_object({}) { |key, hash| hash[key] = character.public_send(key) }

    fields[:score] = score
    update!(fields)
  end
end
