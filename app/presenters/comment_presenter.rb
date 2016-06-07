# frozen_string_literal: true
class CommentPresenter < ApplicationPresenter
  def character
    CharacterPresenter.new(object.character)
  end

  def posted_at
    created_at.to_date.to_s(:long)
  end

  def poster_name
    super || 'Anonymous'
  end

  def timestamp
    created_at.iso8601
  end
end
