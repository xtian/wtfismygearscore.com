class CharactersController < ApplicationController
  def index
    @characters = Character.ranked(rank_scope)
      .where(index_criteria)
      .order(score: :desc, name: :asc)
  end

  def show
    @character = Character.find_or_initialize_by(params.permit(:region, :realm, :name))

    if @character.new_record?
      @character = CharacterUpdater.call(@character)
    else
      CharacterUpdaterJob.perform_later(@character)
    end
  end

  private

  def index_criteria
    @_criteria ||= params.permit(:region, :realm).tap do |params|
      params.delete(:region) if params[:region].casecmp('world') == 0
    end
  end

  def rank_scope
    return { by: :realm } if index_criteria[:realm]
    return { by: :region } if index_criteria[:region]
    {}
  end
end
