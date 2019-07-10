# typed: true
# frozen_string_literal: true

module HomeHelper
  # @return [Array<Array>] options for region `<select>`
  def region_options
    VALID_REGIONS_WITH_REALM.map { |r| [r.upcase, r] }
  end
end
