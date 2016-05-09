require 'rails_helper'
require 'support/armory_helpers'
require 'support/pages/home_page'

RSpec.feature 'Homepage' do
  def home_page
    HomePage.new
  end

  before do
    stub_character_request
    visit '/'
  end

  scenario 'User visits homepage' do
    expect(page).to have_title('WTF is My Gear Score?')
    expect(page).to have_css('script[src="https://www.google-analytics.com/analytics.js"]', visible: false, count: 1)
  end

  scenario 'User submits character info' do
    home_page.fill_name 'Dargonaut'
    home_page.fill_realm 'Shadowmoon'
    home_page.submit

    expect(current_path).to eq(character_path('us', 'Shadowmoon', 'Dargonaut'))
  end

  scenario 'User submits realm info' do
    home_page.fill_realm 'Shadowmoon'
    home_page.submit

    expect(current_path).to eq(characters_path('us', 'Shadowmoon'))
  end

  scenario 'User submits region info' do
    home_page.fill_region 'EU'
    home_page.submit

    expect(current_path).to eq(characters_path('eu'))
  end
end
