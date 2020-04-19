# frozen_string_literal: true

module TimeHelpers
  include ActiveSupport::Testing::TimeHelpers

  # Can help prevent microsecond differences in time comparisons
  def freeze_time(&block)
    travel_to Time.current, &block
  end
end

RSpec.configure do |config|
  config.include TimeHelpers
end
