class CharactersController < ApplicationController
  def show
    character_params = params.values_at(:region, :realm, :name)
    @character = ARMORY.fetch_character(*character_params)
  end
end
