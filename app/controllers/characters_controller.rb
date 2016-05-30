class CharactersController < ApplicationController
  def index
    @characters = Character.ranked(rank_scope)
      .where(index_criteria)
      .order(score: :desc, name: :asc)
  end

  def show
    @character = fetch_character(params.permit(:region, :realm, :name))

    comments = @character.comments.order(created_at: :desc)
    @comments = CommentPresenter.present_collection(comments)
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

  def fetch_character(params)
    character = Character.find_or_initialize_by(params)

    return CharacterUpdater.call(character) if character.new_record?

    CharacterUpdaterJob.perform_later(character)
    character
  end
end
