# frozen_string_literal: true

# Enables router to return 404s for requests with invalid regions.
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
