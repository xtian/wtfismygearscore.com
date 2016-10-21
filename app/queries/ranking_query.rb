# frozen_string_literal: true

# Encapsulates logic for fetching sorted, paginated results from
# characters table
class RankingQuery
  attr_reader :per_page, :realm

  # @option options [Integer] cursor
  # @option options [Symbol] page_direction
  # @option options [Integer] per_page
  # @option options [String, nil] realm
  # @option options [String] region
  def initialize(options)
    options.each { |key, value| instance_variable_set("@#{key}", value) }
  end

  # Convenience method to avoid object initialization
  # @param options [Hash]
  # @return [RankedCharactersPresenter]
  def self.call(options = {})
    new(options).call
  end

  # @return [RankedCharactersPresenter]
  def call
    characters = ranked_characters
      .where(filter_criteria)
      .select(*fields)
      .limit(per_page)

    RankedCharactersPresenter.new(page(characters), self)
  end

  # @return [String] canonical URL to disambiguate duplicate content for SEO
  def canonical_url
    Rails.application.routes.url_helpers.url_for(
      action: 'index',
      controller: 'characters',
      host: Rails.application.secrets.base_url,
      page_direction => cursor,
      per_page: per_page,
      realm: realm,
      region: region
    ).downcase
  end

  # @return [CollectionPresenter<RecentCommentPresenter>]
  def comments
    @_comments ||= begin
      filter = { region: Character.regions[region] }.compact
      comments = RecentComment.where(filter).limit(5).order(created_at: :desc)
      RecentCommentPresenter.present_collection(comments)
    end
  end

  private

  attr_reader :cursor, :page_direction, :region

  def filter_criteria
    { realm: realm, region: (region unless world?) }.compact
  end

  # Certain fields are unnecessary depending on the ranking context
  def fields
    %i(class_name faction id name rank score).tap do |fields|
      fields << :guild_name if realm
      fields << :realm unless realm
      fields << :region if world?
    end
  end

  # Pagination is done by finding results whose sort values are equal to or
  # greater than given cursor. This means that reverse-paginated results will
  # be in reverse order and so the sort must be corrected in memory. We limit
  # results to a maximum number of rows to prevent this from being a
  # significant performance problem.
  def page(characters)
    case page_direction
    when :after
      characters.order(score: :desc, name: :asc, realm: :asc).where(page_criteria(%w(< >))).to_a
    when :before
      characters.order(score: :asc, name: :desc, realm: :desc).where(page_criteria(%w(> <))).to_a.reverse
    else characters.to_a
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
