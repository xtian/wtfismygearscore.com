# frozen_string_literal: true
class RecentCommentPresenter < CommentPresenter
  def character_info
    [character_region, character_realm, character_name]
  end

  def character_link_class
    "CharacterLink--#{class_name}"
  end

  private

  def class_name
    class_name = CLASSES[character_class]
    CharacterPresenter.new(Character.new(class_name)).css_class_name
  end

  def character_region
    VALID_REGIONS_WITH_REALM[super]
  end

  Character = Struct.new(:class_name)
end
