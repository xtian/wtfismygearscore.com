# frozen_string_literal: true
class CollectionPresenter < SimpleDelegator
  include Enumerable

  def initialize(collection, presenter)
    @presenter = presenter
    super collection
  end

  def each
    __getobj__.each { |item| yield @presenter.new(item) }
  end

  def to_ary
    self.class.new(__getobj__.to_ary, @presenter)
  end

  alias collection __getobj__
  private :collection
end
