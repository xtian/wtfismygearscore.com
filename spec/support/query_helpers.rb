# typed: false
# frozen_string_literal: true

module QueryHelpers
  def find_tid(id)
    find("[data-t-#{id}]")
  end

  def all_tid(id)
    all("[data-t-#{id}]")
  end
end

module Capybara
  module Node
    module Finders
      def find_tid(id)
        find("[data-t-#{id}]")
      end

      def all_tid(id)
        all("[data-t-#{id}]")
      end
    end
  end
end

RSpec.configure do |config|
  config.include QueryHelpers
end
