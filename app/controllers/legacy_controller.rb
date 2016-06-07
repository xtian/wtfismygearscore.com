# frozen_string_literal: true
class LegacyController < ApplicationController
  def index
    redirect_to characters_path(*legacy_params), status: :moved_permanently
  end

  def show
    redirect_params = legacy_params.compact

    if redirect_params.length == 3
      redirect_to character_path(*redirect_params), status: :moved_permanently
    else
      not_found
    end
  end

  private

  def legacy_params
    if params[:d]
      params.values_at(:d, :r, :n)
    elsif params[:r]
      params.values_at(:r, :s, :n)
    else
      ['world']
    end
  end
end
