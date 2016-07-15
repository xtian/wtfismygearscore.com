# frozen_string_literal: true
class RecentCommentPresenter < CommentPresenter
  # @return [Array<String>]
  def character_info
    [character_region, character_realm, character_name]
  end

  # @return [String]
  def character_link_class
    "CharacterLink--#{class_name}"
  end

  private

  # RecentComment doesn't have access to the correct character enum field
  # values so these methods accomodate for that.

  def class_name
    class_name = CLASSES[character_class]
    CharacterPresenter.new(Character.new(class_name)).css_class_name
  end

  def character_region
    VALID_REGIONS_WITH_REALM[super]
  end

  Character = Struct.new(:class_name)
end
