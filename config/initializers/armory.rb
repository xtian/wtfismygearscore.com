require 'armory'

Rails.application.config.to_prepare do
  ARMORY = Armory.new(Rails.application.secrets.armory_api_key)
end
