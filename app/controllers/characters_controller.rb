# frozen_string_literal: true
class CharactersController < ApplicationController
  rescue_from 'Armory::NotFoundError', with: :not_found

  def index
    @ranking = RankingQuery.call(
      cursor: params[:after] || params[:before],
      page_direction: page_direction,
      per_page: per_page,
      realm: params[:realm],
      region: params[:region]
    )
  end

  def show
    character = fetch_character(params.permit(:region, :realm, :name))
    @character = CharacterPresenter.new(character)
  end

  private

  def fetch_character(params)
    character = Character.find_or_initialize_by(params)

    return CharacterUpdater.call(character) if character.new_record?

    CharacterUpdaterJob.perform_later(character)
    character
  end

  def page_direction
    return :after if params[:after]
    :before if params[:before]
  end

  def per_page
    [params[:per_page]&.to_i, 50].compact.min
  end

  def world_page?
    @_world_page ||= !REALM_REGIONS_SET.include?(params[:region].downcase)
  end
  helper_method :world_page?
end
