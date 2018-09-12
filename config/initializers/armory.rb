# frozen_string_literal: true

require 'armory'

api_key = Rails.application.secrets.armory_api_key
timeout = 12

ARMORY = Armory.new(api_key, timeout)
