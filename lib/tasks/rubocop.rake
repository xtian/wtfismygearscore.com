# frozen_string_literal: true

if Rails.env.in? %w[development test]
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new(:rubocop) do |task|
    task.formatters = ['fuubar']
  end
end
