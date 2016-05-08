class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def secrets
    Rails.application.secrets
  end
  helper_method :secrets

  def regions
    %i(us eu kr tw cn).freeze
  end
  helper_method :regions
end
