class Character < ApplicationRecord
  enum class_name: CLASSES
  enum region: VALID_REGIONS_WITH_REALM

  validates :class_name, :name, :realm, :region, presence: true

  validates :avg_ilvl, :level, :max_ilvl, :min_ilvl, :score,
            numericality: { only_integer: true, greater_than: 0 }, presence: true

  def self.ranked(by: nil)
    partition = if by == :region
                  'PARTITION BY region'
                elsif by == :realm
                  'PARTITION BY realm, region'
                end

    from <<-SQL.strip_heredoc
      (SELECT *, rank() OVER (#{partition} ORDER BY score DESC) FROM characters) AS characters
    SQL
  end

  def update_from_armory(character, score)
    fields = %i(guild_name class_name level name realm).each_with_object({}) do |key, hash|
      hash[key] = character.public_send(key)
    end

    fields[:avg_ilvl] = character.average_ilvl
    fields[:max_ilvl] = character.maximum_ilvl
    fields[:min_ilvl] = character.minimum_ilvl
    fields[:score] = score

    update!(fields)
  end
end
