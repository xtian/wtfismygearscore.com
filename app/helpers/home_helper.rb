module HomeHelper
  def character_link(character)
    css_class_name = character.class_name.parameterize.underscore.camelize(:lower)
    link_to(character.name, character, class: "CharacterLink--#{css_class_name}")
  end

  def region_options
    VALID_REGIONS_WITH_REALM.map { |r| [r.upcase, r] }
  end
end
