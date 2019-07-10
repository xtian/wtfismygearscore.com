# typed: true
# frozen_string_literal: true

class CharactersController < ApplicationController
  rescue_from 'Armory::NotFoundError', with: :not_found

  rescue_from 'Armory::ServerError' do
    render file: Rails.public_path.join('502.html'), status: 502, layout: false
  end

  def index
    @ranking = RankingQuery.call(
      page: page,
      per_page: per_page(25),
      realm: params[:realm],
      region: downcased_region
    )
  end

  def show
    @character = CharacterQuery.call(
      name: params[:name],
      page: page,
      per_page: per_page(10),
      realm: params[:realm],
      region: downcased_region
    )
  end

  private

  # Defaults/limits `page` param to 1
  def page
    [params[:page].to_i, 1].max
  end
  helper_method :page

  # Defaults/limits `per_page` param to `max`
  def per_page(max)
    param = params[:per_page].to_i
    param.positive? ? [param, max].min : max
  end

  def downcased_region
    @_downcased_region ||= params[:region].downcase
  end

  # Returns `true` if `/world` was requested
  def world_page?
    @_world_page ||= !REALM_REGIONS_SET.include?(downcased_region)
  end
  helper_method :world_page?
end
