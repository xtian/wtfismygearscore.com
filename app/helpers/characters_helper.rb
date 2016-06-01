module CharactersHelper
  def extra_column_name
    return 'Guild' if params[:realm]
    'Realm'
  end

  def extra_column(character)
    return character.guild_name if character.respond_to?(:guild_name)

    name = [
      (character.region.upcase if character.respond_to?(:region)),
      character.realm.titleize
    ].compact.join('-')

    parts = %i(region realm).map do |field|
      character.respond_to?(field) ? character.public_send(field).downcase : params[field]
    end

    link_to name, characters_path(*parts)
  end

  def ranking_title(region, realm)
    region = region.casecmp('world') == 0 ? region.humanize : region.upcase

    [region, realm&.humanize].compact.join('–') + ' WoW Character Ranking'
  end
end
