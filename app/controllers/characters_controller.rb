class CharactersController < ApplicationController
  def index
    @characters = Character.ranked(rank_scope)
      .where(index_criteria)
      .order(score: :desc, name: :asc)
  end

  def show
    character_params = params.values_at(:region, :realm, :name)

    @character = ARMORY.fetch_character(*character_params)
    @score = GearscoreCalculator.calculate(@character.items)

    Character.update_from_armory(@character, @score)
  end

  private

  def index_criteria
    @_criteria ||= {}.tap do |hash|
      hash[:region] = params[:region] if params[:region].casecmp('world') != 0
      hash[:realm] = params[:realm] if params[:realm]
    end
  end

  def rank_scope
    return { by: :realm } if index_criteria[:realm]
    return { by: :region } if index_criteria[:region]
    {}
  end
end
