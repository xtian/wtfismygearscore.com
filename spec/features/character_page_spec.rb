require 'rails_helper'
require 'support/armory_helpers'

RSpec.feature 'Character page' do
  before do
    stub_character_request
  end

  scenario 'User visits character page' do
    visit '/us/shadowmoon/dargonaut'

    expect(page).to have_title('Dargonaut, 100 Hunter — WTF is My Gear Score?')
  end
end
