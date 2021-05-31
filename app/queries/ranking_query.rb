# frozen_string_literal: true

# Encapsulates logic for fetching sorted, paginated results from
# characters table
class RankingQuery
  attr_reader :page, :per_page, :realm

  # @option options [Integer] page
  # @option options [Integer] per_page
  # @option options [String, nil] realm
  # @option options [String] region
  def initialize(page:, per_page:, region:, realm: nil)
    @page = page
    @per_page = per_page
    @region = region
    @realm = realm
  end

  # Convenience method to avoid object initialization
  # @param options [Hash]
  # @return [RankedCharactersPresenter]
  def self.call(options = {})
    new(**options).call
  end

  # @return [RankedCharactersPresenter]
  def call
    characters = ranked_characters
      .select(*fields)
      .where(filter_criteria)
      .order(score: :desc, name: :asc, realm: :asc)
      .limit(per_page)

    RankedCharactersPresenter.new(paginate(characters), self)
  end

  # @return [String] canonical URL to disambiguate duplicate content for SEO
  def canonical_url
    Rails.application.routes.url_helpers.url_for(
      action: "index",
      controller: "characters",
      host: Rails.application.secrets.base_url,
      page: page,
      per_page: per_page,
      realm: realm,
      region: region,
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

  attr_reader :region

  def filter_criteria
    { realm: realm, region: (region unless world?) }.compact
  end

  # Certain fields are unnecessary depending on the ranking context
  def fields
    %i[class_name faction id name rank score].tap do |fields|
      fields << :guild_name if realm
      fields << :realm unless realm
      fields << :region if world?
    end
  end

  def paginate(characters)
    return characters if page.eql?(1)

    characters.where("row_number >= ?", ((page - 1) * per_page) + 1)
  end

  def ranking_partition
    @_ranking_partition ||= if realm
        "PARTITION BY realm, region"
      elsif !world?
        "PARTITION BY region"
      end
  end

  def ranked_characters
    Character.from <<-SQL.squish.strip_heredoc
      (
        SELECT *,
          rank() OVER (#{ranking_partition} ORDER BY score DESC),
          row_number() OVER (#{ranking_partition} ORDER BY score DESC)
        FROM characters
        WHERE last_login_at > '2020-10-13'
      ) AS characters
    SQL
  end

  def world?
    @_world ||= REALM_REGIONS_SET.exclude?(region.downcase)
  end
end
