require 'support/query_helpers'

class Page
  include Capybara::DSL
  include QueryHelpers

  def notice_message
    find_tid(:notice).text
  end
end
