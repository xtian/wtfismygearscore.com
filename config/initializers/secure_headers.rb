# frozen_string_literal: true
SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true,
    httponly: true,
    samesite: { lax: true }
  }

  config.hsts = SecureHeaders::OPT_OUT

  # rubocop:disable Lint/PercentStringArray
  config.csp = {
    report_only: false,
    preserve_schemes: false,

    default_src: %w('none'),
    connect_src: %w('self') << (Rails.env.production? ? 'wss:' : 'ws:'),
    img_src: %w('self' data: www.google-analytics.com),
    script_src: %w('self' www.google-analytics.com),
    style_src: %w('self'),

    block_all_mixed_content: true,
    upgrade_insecure_requests: Rails.env.production?
  }
  # rubocop:enable Lint/PercentStringArray
end
