# frozen_string_literal: true
class Character < ApplicationRecord
  enum class_name: CLASSES
  enum faction: FACTIONS
  enum region: VALID_REGIONS_WITH_REALM

  has_many :comments

  validates :class_name, :level, :name, :realm, :region, :score, presence: true
  validates :level, numericality: { only_integer: true, greater_than: 0 }
  validates :score, numericality: { only_integer: true }

  validates :avg_ilvl, :max_ilvl, :min_ilvl,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true

  # @param region [String]
  # @param realm [String]
  # @param name [String]
  # @return [Character] cached character or unsaved character initialized from params
  def self.from_params(region:, realm:, name:)
    character = with_realm(realm).find_by(region: region, name: name)
    character || new(region: region, realm: realm, name: name)
  end

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
  # @return [void]
  def update_from_armory(character, score)
    fields = %i(avg_ilvl class_name faction guild_name level max_ilvl min_ilvl name realm)
      .each_with_object({}) { |key, hash| hash[key] = character.public_send(key) }

    fields[:score] = score
    update!(fields)
  end

  def self.with_realm(realm)
    query = "characters.realm = :realm OR :realm = ANY(realms.translations)"
    undasherized = realm.tr('-', ' ')

    joined = joins('JOIN realms ON realms.name = characters.realm')
    filtered = joined.where(query, realm: realm)

    return filtered if realm.eql?(undasherized)

    filtered.or(joined.where(query, realm: undasherized))
  end
  private_class_method :with_realm
end
