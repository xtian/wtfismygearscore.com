# frozen_string_literal: true
if Rails.env.in? %w(production)
  Rack::Timeout.service_timeout = Rails.application.secrets.request_timeout.to_i
end
