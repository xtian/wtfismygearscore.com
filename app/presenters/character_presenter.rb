# frozen_string_literal: true
class CharacterPresenter < ApplicationPresenter
  # @return [String] URL to character's Armory page
  def armory_url
    # If trailing slash is left off, Armory will return 404.
    "https://#{region}.battle.net/wow/en/character/#{realm}/#{name}/"
  end

  # @return [String] character's class converted to CSS class identifier
  def css_class_name
    class_name.parameterize.underscore.camelize(:lower)
  end

  # @return [Array<CommentPresenter>]
  def comments
    CommentPresenter.present_collection(super)
  end

  # @return [String]
  def info
    "#{name.humanize}, #{level} #{class_name.titleize}"
  end

  # @return [Fixnum, Float] median difference with trailing zero trimmed
  def median_difference
    float = super
    int = float.to_i
    int == float ? int : float
  end

  # @return [String]
  def rating
    median_difference >= 0 ? 'win' : 'fail'
  end
end
