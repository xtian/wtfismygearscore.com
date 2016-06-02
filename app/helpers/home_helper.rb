module HomeHelper
  def character_link(character)
    link_to(character.name, character, class: "CharacterLink--#{character.css_class_name}")
  end

  def region_options
    VALID_REGIONS_WITH_REALM.map { |r| [r.upcase, r] }
  end
end
