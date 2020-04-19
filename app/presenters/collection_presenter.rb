# typed: ignore
# frozen_string_literal: true

# Wraps collection in a presenter which responds to `#each` and `#to_ary` which
# are required by Rails' `render` helper
class CollectionPresenter < SimpleDelegator
  include Enumerable

  def initialize(collection, presenter)
    @presenter = presenter
    super collection
  end

  # @return [Array]
  def each
    __getobj__.each { |item| yield @presenter.new(item) }
  end

  # Calls `#to_ary` on underlying collection and re-wraps return value
  # @return [CollectionPresenter]
  def to_ary
    self.class.new(__getobj__.to_ary, @presenter)
  end

  alias collection __getobj__

  private :collection
end
