class CharacterPresenter < ApplicationPresenter
  def css_class_name
    object.class_name.parameterize.underscore.camelize(:lower)
  end
end
