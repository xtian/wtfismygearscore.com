# typed: false
# frozen_string_literal: true

class RankedCharactersPresenter < CollectionPresenter
  delegate :canonical_url, :comments, :page, to: :query

  # @param characters [Enumerable<Character>]
  # @param query [RankingQuery]
  def initialize(characters, query)
    @query = query
    super(characters, CharacterPresenter)
  end

  # @return [String]
  def extra_column_name
    query.realm ? "Guild" : "Realm"
  end

  # @return [Boolean]
  def first_page?
    query.page.eql?(1)
  end

  # @return [Boolean]
  def last_page?
    collection.length < query.per_page
  end

  private

  attr_reader :query
end
