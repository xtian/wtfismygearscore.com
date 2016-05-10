class Character < ApplicationRecord
  enum character_class: CLASSES
  enum region: VALID_REGIONS_WITH_REALM

  validates :character_class, :level, :name, :realm, :region, :score, presence: true
  validates :level, :score, numericality: { only_integer: true, greater_than: 0 }
end
