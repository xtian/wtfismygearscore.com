require 'rails_helper'

RSpec.feature 'Homepage' do
  scenario 'User visits homepage' do
    visit '/'

    expect(page).to have_title('WTF is My Gear Score?')
  end
end
