# frozen_string_literal: true
class RankingQuery
  attr_reader :per_page, :realm

  def initialize(options)
    options.each { |key, value| instance_variable_set("@#{key}", value) }
  end

  def self.call(options = {})
    new(options).call
  end

  def call
    characters = ranked_characters
      .where(filter_criteria)
      .select(*fields)
      .limit(per_page)

    RankedCharactersPresenter.new(page(characters), self)
  end

  private

  attr_reader :cursor, :page_direction, :region

  def filter_criteria
    { realm: realm, region: (region unless world?) }.compact
  end

  def fields
    %i(class_name faction id name rank score).tap do |fields|
      fields << :guild_name if realm
      fields << :realm unless realm
      fields << :region if world?
    end
  end

  def page(characters)
    case page_direction
    when :after
      characters.order(score: :desc, name: :asc, realm: :asc).where(page_criteria(%w(< >))).to_a
    when :before
      characters.order(score: :asc, name: :desc, realm: :desc).where(page_criteria(%w(> <))).to_a.reverse
    else characters
    end
  end

  def page_criteria(comparisons)
    return unless cursor
    character = Character.find(cursor)

    query = <<-SQL.strip_heredoc
      score #{comparisons[0]} ?
      OR
      (score = ? AND (name #{comparisons[1]} ? OR realm #{comparisons[1]} ?))
    SQL

    [query, character.score, character.score, character.name, character.realm]
  end

  def ranked_characters
    partition = 'PARTITION BY realm, region' if realm
    partition ||= 'PARTITION BY region' unless world?

    Character.from <<-SQL.strip_heredoc
      (SELECT *, rank() OVER (#{partition} ORDER BY score DESC) FROM characters) AS characters
    SQL
  end

  def world?
    @_world ||= !REALM_REGIONS_SET.include?(region.downcase)
  end
end
