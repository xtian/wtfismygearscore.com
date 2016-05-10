class RegionConstraint
  def matches?(request)
    region = request.params[:region]

    if request.params[:realm]
      region.in?(VALID_REGIONS_WITH_REALM)
    else
      region.in?(VALID_REGIONS)
    end
  end
end
