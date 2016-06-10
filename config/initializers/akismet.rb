# frozen_string_literal: true
require 'akismet'

key = Rails.application.secrets.akismet_key
url = Rails.application.secrets.akismet_url
is_test = Rails.env.in?(%w(development test))

AKISMET = Akismet.new(key: key, url: url, is_test: is_test) if key && url
