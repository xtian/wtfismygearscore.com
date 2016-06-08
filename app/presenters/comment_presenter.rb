# frozen_string_literal: true
class CommentPresenter < ApplicationPresenter
  def avatar
    RubyIdenticon.create_base64(
      poster_ip_address.to_s,
      border_size: 0,
      grid_size: 9,
      square_size: 2,
      key: Rails.application.secrets.identicon_key
    )
  end

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
