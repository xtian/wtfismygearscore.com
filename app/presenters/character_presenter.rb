# frozen_string_literal: true
class CharacterPresenter < ApplicationPresenter
  def armory_url
    "https://#{region}.battle.net/wow/en/character/#{realm}/#{name}/"
  end

  def css_class_name
    class_name.parameterize.underscore.camelize(:lower)
  end

  def comments
    CommentPresenter.present_collection(super)
  end

  def info
    "#{name.humanize}, #{level} #{class_name.titleize}"
  end

  def median_difference
    float = super
    int = float.to_i
    int == float ? int : float
  end

  def rating
    median_difference >= 0 ? 'win' : 'fail'
  end
end
