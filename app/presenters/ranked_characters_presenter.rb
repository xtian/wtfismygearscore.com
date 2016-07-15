# frozen_string_literal: true
class RankedCharactersPresenter < CollectionPresenter
  def initialize(characters, query)
    @query = query
    super(characters, CharacterPresenter)
  end

  def extra_column_name
    query.realm ? 'Guild' : 'Realm'
  end

  def first_page?
    !collection.first || collection.first.rank == 1
  end

  def last_page?
    collection.size < query.per_page
  end

  def next_cursor
    collection.last&.id
  end

  def prev_cursor
    collection.first&.id
  end

  private

  attr_reader :query
end
