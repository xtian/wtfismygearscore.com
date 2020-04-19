# frozen_string_literal: true

class CharacterPresenter < ApplicationPresenter
  delegate :canonical_url, :first_page?, :last_page?, to: :query

  def initialize(character, query = nil)
    @query = query
    super character
  end

  # @return [String] URL to character's Armory page
  def armory_url
    "https://worldofwarcraft.com/en-us/character/#{region}/#{realm}/#{name}"
  end

  # @return [String] character's class converted to CSS class identifier
  def css_class_name
    class_name.parameterize.underscore.camelize(:lower)
  end

  # @return [CollectionPresenter<CommentPresenter>]
  def comments
    CommentPresenter.present_collection(query.comments)
  end

  # @return [String]
  def info
    "#{name.humanize}, #{level} #{class_name.titleize}"
  end

  # @return [Integer, Float] median difference with trailing zero trimmed
  def median_difference
    float = super
    int = float.to_i
    int == float ? int : float
  end

  # @return [String]
  def rating
    median_difference >= 0 ? "win" : "fail"
  end

  private

  attr_reader :query
end
