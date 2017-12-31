# frozen_string_literal: true

timeout = Rails.application.secrets.request_timeout.to_i

Rack::Timeout.service_timeout = timeout if Rails.env.in? %w[production]
