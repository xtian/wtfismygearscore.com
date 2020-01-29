# typed: true
# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :character

  validates :body, length: { maximum: 1000 }, presence: true
  validates :poster_ip_address, presence: true
  validates :poster_name, length: { maximum: 15 }

  # @param value [String]
  # @return [String] input value stripped of extranneous whitespace
  def body=(value)
    value = value&.strip&.presence
    super ActionController::Base.helpers.strip_tags(value)
  end

  # @param value [String]
  # @return [String] input value stripped of extranneous whitespace
  def poster_name=(value)
    super value&.strip&.presence
  end
end
