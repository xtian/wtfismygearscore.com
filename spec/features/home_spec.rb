require 'rails_helper'

RSpec.feature 'Homepage' do
  scenario 'User visits homepage' do
    visit '/'

    expect(page).to have_title('WTF is My Gear Score?')
    expect(page).to have_css('script[src="https://www.google-analytics.com/analytics.js"]', visible: false, count: 1)
  end
end
