class ApplicationPresenter < SimpleDelegator
  def self.present_collection(collection)
    CollectionProxy.new(collection, self)
  end

  alias object __getobj__
  private :object

  class CollectionProxy < SimpleDelegator
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
  end
end
