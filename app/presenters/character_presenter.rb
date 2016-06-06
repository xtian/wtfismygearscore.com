class CharacterPresenter < ApplicationPresenter
  def armory_url
    "https://#{region}.battle.net/wow/en/character/#{realm}/#{name}/"
  end

  def css_class_name
    object.class_name.parameterize.underscore.camelize(:lower)
  end

  def comments
    CommentPresenter.present_collection(super)
  end

  def info
    "#{name.humanize}, #{level} #{class_name.titleize}"
  end
end
