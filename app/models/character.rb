# frozen_string_literal: true
class Character < ApplicationRecord
  enum class_name: CLASSES
  enum faction: FACTIONS
  enum region: VALID_REGIONS_WITH_REALM

  has_many :comments, -> { order(created_at: :desc) }

  validates :class_name, :name, :realm, :region, presence: true

  validates :avg_ilvl, :level, :max_ilvl, :min_ilvl, :score,
            numericality: { only_integer: true, greater_than: 0 }, presence: true

  def create_comment(params)
    comments.create(params)
  end

  def median_difference
    @_median_difference ||= begin
      median_score = MedianGearscore.find_or_initialize_by(level: level).median_score
      score - median_score
    end
  end

  def update_from_armory(character, score)
    fields = %i(avg_ilvl class_name faction guild_name level max_ilvl min_ilvl name realm)
      .each_with_object({}) { |key, hash| hash[key] = character.public_send(key) }

    fields[:score] = score
    update!(fields)
  end
end
