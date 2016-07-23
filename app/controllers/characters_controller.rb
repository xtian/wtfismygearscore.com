# frozen_string_literal: true
class CharactersController < ApplicationController
  rescue_from 'Armory::NotFoundError', with: :not_found

  def index
    @ranking = RankingQuery.call(
      cursor: params[:after] || params[:before],
      page_direction: page_direction,
      per_page: per_page(50),
      realm: params[:realm],
      region: region
    )
  end

  def show
    @character = CharacterQuery.call(
      name: params[:name],
      page: page,
      per_page: per_page(10),
      realm: params[:realm],
      region: region
    )
  end

  private

  # Defaults/limits `page` param to 1
  def page
    [params[:page].to_i, 1].max
  end
  helper_method :page

  # Pagination direction based on provided cursor
  def page_direction
    return :after if params[:after]
    :before if params[:before]
  end

  # Defaults/limits `per_page` param to `max`
  def per_page(max)
    param = params[:per_page].to_i
    param > 0 ? [param, max].min : max
  end

  def region
    @_downcased_region ||= params[:region].downcase
  end

  # Returns `true` if `/world` was requested
  def world_page?
    @_world_page ||= !REALM_REGIONS_SET.include?(region)
  end
  helper_method :world_page?
end
