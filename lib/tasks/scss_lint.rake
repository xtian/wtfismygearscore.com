# frozen_string_literal: true
if Rails.env.in? %w(development test)
  require 'scss_lint/rake_task'

  SCSSLint::RakeTask.new do |t|
    t.files = ['app/assets/stylesheets']
  end
end
