# frozen_string_literal: true
require 'ruby_identicon'

class CommentPresenter < ApplicationPresenter
  # @return [String] Base64 PNG of identicon based on poster's ip address
  def avatar
    RubyIdenticon.create_base64(
      poster_ip_address.to_s,
      border_size: 0,
      grid_size: 9,
      square_size: 2,
      key: Rails.application.secrets.identicon_key
    )
  end

  # @return [CharacterPresenter]
  def character
    CharacterPresenter.new(object.character)
  end

  # @return [String]
  def posted_at
    created_at.to_date.to_s(:long)
  end

  # @return [String]
  def poster_name
    super || 'Anonymous'
  end

  # @return [String]
  def timestamp
    created_at.iso8601
  end
end
