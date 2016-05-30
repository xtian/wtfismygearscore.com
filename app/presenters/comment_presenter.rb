class CommentPresenter < ApplicationPresenter
  def posted_at
    object.created_at.to_date.to_s(:long)
  end

  def poster_name
    object.poster_name || 'Anonymous'
  end

  def timestamp
    object.created_at.iso8601
  end
end
