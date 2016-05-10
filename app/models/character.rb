class Character < ApplicationRecord
  enum character_class: CLASSES
  enum region: VALID_REGIONS_WITH_REALM

  validates :character_class, :level, :name, :realm, :region, :score, presence: true
  validates :level, :score, numericality: { only_integer: true, greater_than: 0 }

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
end
