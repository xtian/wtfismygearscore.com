# frozen_string_literal: true
require 'securerandom'

class ApplicationController < ActionController::Base
  helper UrlHelper

  before_action :set_uuid

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def secrets
    Rails.application.secrets
  end
  helper_method :secrets

  def set_uuid
    cookies.signed[:uuid] ||= SecureRandom.uuid
  end
end
