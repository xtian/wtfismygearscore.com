require 'rails_helper'
require 'support/page_objects/homepage_form'

RSpec.feature 'Homepage' do
  def form
    HomepageForm.new
  end

  before do
    visit '/'
  end

  scenario 'User visits homepage' do
    expect(page).to have_title('WTF is My Gear Score?')
    expect(page).to have_css('script[src="https://www.google-analytics.com/analytics.js"]', visible: false, count: 1)
  end

  scenario 'User submits character info' do
    form.fill_name 'Dargonaut'
    form.fill_realm 'Shadowmoon'
    form.submit

    expect(current_path).to eq(character_path('us', 'Shadowmoon', 'Dargonaut'))
  end

  scenario 'User submits realm info' do
    form.fill_realm 'Shadowmoon'
    form.submit

    expect(current_path).to eq(characters_path('us', 'Shadowmoon'))
  end

  scenario 'User submits region info' do
    form.fill_region 'EU'
    form.submit

    expect(current_path).to eq(characters_path('eu'))
  end
end
