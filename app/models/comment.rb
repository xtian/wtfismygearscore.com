# frozen_string_literal: true
class Comment < ApplicationRecord
  belongs_to :character

  delegate :name, to: :character, prefix: true

  validates :body, length: { maximum: 1000 }, presence: true
  validates :poster_ip_address, presence: true
  validates :poster_name, length: { maximum: 15 }

  def body=(value)
    super value&.strip.presence
  end

  def poster_name=(value)
    super value&.strip.presence
  end
end
