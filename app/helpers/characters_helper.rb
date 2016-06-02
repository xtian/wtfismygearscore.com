module CharactersHelper
  REGION_REALM_SEPARATOR = '-'.freeze

  def character_path(character)
    parts = server_parts(character)
    parts << character.name.downcase
    super(*parts)
  end

  def extra_column_name
    return 'Guild' if params[:realm]
    'Realm'
  end

  def extra_column(character)
    return character.guild_name if character.respond_to?(:guild_name)

    name = [
      (character.region.upcase if character.respond_to?(:region)),
      character.realm.titleize
    ].compact.join(REGION_REALM_SEPARATOR)

    parts = server_parts(character)
    link_to name, characters_path(*parts)
  end

  def ranking_title(region, realm)
    [region, realm].compact.join(REGION_REALM_SEPARATOR) + ' WoW Character Ranking'
  end

  def region
    region = params[:region]
    world_page? ? region.titleize : region.upcase
  end

  def realm
    params[:realm]&.titleize
  end

  def server_parts(character = nil)
    %i(region realm).map do |field|
      character&.respond_to?(field) ? character.public_send(field).downcase : params[field]
    end
  end
end
