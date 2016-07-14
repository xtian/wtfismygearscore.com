# frozen_string_literal: true
module CharactersHelper
  REGION_REALM_SEPARATOR = '-'

  def character_path(character)
    parts = [*server_parts(character), character.name]
    super(*parts)
  end

  def extra_column(character)
    return character.guild_name if character.respond_to?(:guild_name)

    name = [
      (character.region.upcase if character.respond_to?(:region)),
      character.realm.titleize
    ].compact.join(REGION_REALM_SEPARATOR)

    link_to name, characters_path(*server_parts(character))
  end

  def next_ranking_path(cursor)
    characters_path(*server_parts, after: cursor, per_page: params[:per_page])
  end

  def prev_ranking_path(cursor)
    characters_path(*server_parts, before: cursor, per_page: params[:per_page])
  end

  def ranking_title
    [region, realm].compact.join(REGION_REALM_SEPARATOR) + ' WoW Character Ranking'
  end

  def realm
    params[:realm]&.titleize
  end

  def region
    region = params[:region]
    world_page? ? region.titleize : region.upcase
  end

  def server_parts(character = nil)
    %i(region realm).map do |field|
      character&.respond_to?(field) ? character.public_send(field).downcase : params[field]
    end
  end
end
