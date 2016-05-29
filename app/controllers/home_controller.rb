class HomeController < ApplicationController
  def redirect
    redirect_to destination_url(redirect_params), status: :moved_permanently
  end

  def show
    @comments = Comment.order(created_at: :desc).limit(5)
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
