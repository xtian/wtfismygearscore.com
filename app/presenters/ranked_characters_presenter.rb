# frozen_string_literal: true
class RankedCharactersPresenter < CollectionPresenter
  delegate :canonical_url, :comments, to: :query

  # @param characters [Enumerable<Character>]
  # @param query [RankingQuery]
  def initialize(characters, query)
    @query = query
    super(characters, CharacterPresenter)
  end

  # @return [String]
  def extra_column_name
    query.realm ? 'Guild' : 'Realm'
  end

  # @return [Boolean]
  def first_page?
    !collection.first || collection.first.rank == 1
  end

  # @return [Boolean]
  def last_page?
    collection.size < query.per_page
  end

  # @return [Fixnum, nil]
  def next_cursor
    collection.last&.id
  end

  # @return [Fixnum, nil]
  def prev_cursor
    collection.first&.id
  end

  private

  attr_reader :query
end
