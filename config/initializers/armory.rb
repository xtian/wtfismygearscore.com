# frozen_string_literal: true
require 'armory'

api_key = Rails.application.secrets.armory_api_key
timeout = Rails.application.secrets.request_timeout.to_i - 1

ARMORY = Armory.new(api_key, timeout)
