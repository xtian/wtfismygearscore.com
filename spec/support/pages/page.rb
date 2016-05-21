require 'support/query_helpers'

class Page
  include Capybara::DSL
  include QueryHelpers
end
