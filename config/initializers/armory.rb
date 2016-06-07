# frozen_string_literal: true
require 'armory'

ARMORY = Armory.new(Rails.application.secrets.armory_api_key)
