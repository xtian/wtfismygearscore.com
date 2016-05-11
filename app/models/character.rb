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
    update_attributes!(
      avg_ilvl: character.average_ilvl,
      class_name: character.class_name,
      level: character.level,
      max_ilvl: character.maximum_ilvl,
      min_ilvl: character.minimum_ilvl,
      score: score
    )
  end
end
