# frozen_string_literal: true
class Comment < ApplicationRecord
  include Rakismet::Model

  belongs_to :character

  validates :body, length: { maximum: 1000 }, presence: true
  validates :poster_ip_address, presence: true
  validates :poster_name, length: { maximum: 15 }

  rakismet_attrs author: :poster_name, content: :body, user_ip: proc { poster_ip_address.to_s }

  def body=(value)
    super value&.strip.presence
  end

  def poster_name=(value)
    super value&.strip.presence
  end
end
