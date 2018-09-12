# frozen_string_literal: true

env = ENV.fetch('RACK_ENV', 'development')

environment env

plugin 'heroku' if env.eql?('production')
plugin 'tmp_restart' if env.eql?('development')

worker_timeout 15
worker_shutdown_timeout 8
