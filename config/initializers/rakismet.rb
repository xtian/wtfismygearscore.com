# frozen_string_literal: true
if Rails.application.secrets.akismet_key
  Rails.application.config.rakismet.key = Rails.application.secrets.akismet_key
  Rails.application.config.rakismet.url = Rails.application.secrets.akismet_domain
end
