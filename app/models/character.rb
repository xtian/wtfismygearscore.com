class Character < ApplicationRecord
  enum class_name: CLASSES
  enum region: VALID_REGIONS_WITH_REALM

  has_many :comments

  validates :class_name, :name, :realm, :region, presence: true

  validates :avg_ilvl, :level, :max_ilvl, :min_ilvl, :score,
            numericality: { only_integer: true, greater_than: 0 }, presence: true

  def self.ranked(by: nil)
    partition = case by
                when :region then 'PARTITION BY region'
                when :realm then 'PARTITION BY realm, region'
                end

    from <<-SQL.strip_heredoc
      (SELECT *, rank() OVER (#{partition} ORDER BY score DESC) FROM characters) AS characters
    SQL
  end

  def create_comment(params)
    comments.create(params)
  end

  def update_from_armory(character, score)
    fields = %i(avg_ilvl class_name guild_name level max_ilvl min_ilvl name realm)
      .each_with_object({}) { |key, hash| hash[key] = character.public_send(key) }

    fields[:score] = score
    update!(fields)
  end
end
