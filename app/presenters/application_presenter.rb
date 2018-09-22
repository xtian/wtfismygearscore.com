# frozen_string_literal: true

class ApplicationPresenter < SimpleDelegator
  def self.present_collection(collection, presenter = CollectionPresenter)
    presenter.new(collection, self)
  end

  alias object __getobj__

  # rubocop:disable Style/AccessModifierDeclarations
  private :object
  # rubocop:enable Style/AccessModifierDeclarations
end
