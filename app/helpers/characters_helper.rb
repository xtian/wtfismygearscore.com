# frozen_string_literal: true
module CharactersHelper
  REGION_REALM_SEPARATOR = '-'

  # @param character [Character]
  # @return [String] path to character page
  def character_path(character)
    parts = [*server_parts(character), character.name]
    super(*parts)
  end

  # @param character [Character]
  # @return [String] value for extra column in ranking table
  def extra_column(character)
    return character.guild_name if character.respond_to?(:guild_name)

    name = [
      (character.region.upcase if character.respond_to?(:region)),
      character.realm.titleize
    ].compact.join(REGION_REALM_SEPARATOR)

    link_to name, characters_path(*server_parts(character))
  end

  # @param cursor [Fixnum] ID of last {Character} on ranking page
  # @return [String] path to next ranking page
  def next_ranking_path(cursor)
    characters_path(*server_parts, after: cursor, per_page: params[:per_page])
  end

  # @param cursor [Fixnum] ID of first {Character} on ranking page
  # @return [String] path to previous ranking page
  def prev_ranking_path(cursor)
    characters_path(*server_parts, before: cursor, per_page: params[:per_page])
  end

  # @return [String]
  def ranking_title
    [region, realm].compact.join(REGION_REALM_SEPARATOR) + ' WoW Character Ranking'
  end

  # @return [String, nil]
  def realm
    params[:realm]&.titleize
  end

  # @return [String]
  def region
    region = params[:region]
    world_page? ? region.titleize : region.upcase
  end

  # Infers region and realm from page params if they are not present on
  # the provided {Character}
  # @param character [Character]
  # @return [Array<String>] region and realm for page or given {Character}
  def server_parts(character = nil)
    %i(region realm).map do |field|
      character&.respond_to?(field) ? character.public_send(field).downcase : params[field]
    end
  end
end
