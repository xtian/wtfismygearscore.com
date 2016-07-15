# frozen_string_literal: true
class RegionConstraint
  def matches?(request)
    region = request.params[:region].downcase

    if request.params[:realm]
      REALM_REGIONS_SET.include?(region)
    else
      REGIONS_SET.include?(region)
    end
  end
end
