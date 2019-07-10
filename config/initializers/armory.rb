# typed: true
# frozen_string_literal: true

require 'armory'

client_id = Rails.application.secrets.blizzard_client_id
client_secret = Rails.application.secrets.blizzard_client_secret
timeout = 12

ARMORY = Armory.new(
  client_id: client_id,
  client_secret: client_secret,
  timeout: timeout
)
