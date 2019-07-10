# typed: false
# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'region routing' do
  VALID_REGIONS.each do |region|
    it "routes /#{region} to characters#index" do
      expect(get: "/#{region}").to route_to(
        controller: 'characters',
        action: 'index',
        region: region
      )
    end
  end

  VALID_REGIONS_WITH_REALM.each do |region|
    it "routes /#{region}/shadowmoon to characters#index" do
      expect(get: "/#{region}/shadowmoon").to route_to(
        controller: 'characters',
        action: 'index',
        realm: 'shadowmoon',
        region: region
      )
    end

    it "routes /#{region}/shadowmoon/dargonaut to characters#show" do
      expect(get: "/#{region}/shadowmoon/dargonaut").to route_to(
        controller: 'characters',
        action: 'show',
        realm: 'shadowmoon',
        name: 'dargonaut',
        region: region
      )
    end
  end

  it 'handles uppercased regions' do
    expect(get: '/WORLD').to be_routable
    expect(get: '/eU').to be_routable
  end

  it 'does not route invalid regions' do
    expect(get: '/foo').not_to be_routable
    expect(get: '/world/shadowmoon').not_to be_routable
    expect(get: '/world/shadowmoon/dargonaut').not_to be_routable
  end
end
# rubocop:enable RSpec/DescribeClass
