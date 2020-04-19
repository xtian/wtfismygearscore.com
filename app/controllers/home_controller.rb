# frozen_string_literal: true

class HomeController < ApplicationController
  def redirect
    redirect_to destination_url(redirect_params), status: :moved_permanently
  end

  def show
    comments = RecentComment.limit(5).order(created_at: :desc)
    @comments = RecentCommentPresenter.present_collection(comments)
  end

  private

  def destination_url(params)
    return character_url(*params) if params.length == 3

    characters_url(*params)
  end

  def redirect_params
    params.require(:redirect)
      .permit(:region, :realm, :name)
      .values_at(:region, :realm, :name)
      .select(&:present?)
  end
end
