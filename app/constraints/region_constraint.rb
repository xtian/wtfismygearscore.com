class RegionConstraint
  REGIONS_SET = Set.new(VALID_REGIONS).freeze
  REALM_REGIONS_SET = Set.new(VALID_REGIONS_WITH_REALM).freeze

  def matches?(request)
    region = request.params[:region].downcase

    if request.params[:realm]
      REALM_REGIONS_SET.include? region
    else
      REGIONS_SET.include? region
    end
  end
end
