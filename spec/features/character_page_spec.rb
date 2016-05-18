require 'rails_helper'
require 'support/armory_helpers'
require 'support/pages/character_page'

RSpec.feature 'Character page' do
  def character_page
    CharacterPage.new
  end

  before do
    stub_character_request
  end

  scenario 'User visits character page' do
    visit character_path('us', 'shadowmoon', 'dargonaut')

    expect(page).to have_title('Dargonaut, 100 Hunter — WTF is My Gear Score?')

    expect(character_page.guild_name).to eq('The Gentlemens Club')

    expect(character_page.score).to eq(19_717)
    expect(character_page.min_ilvl).to eq(655)
    expect(character_page.avg_ilvl).to eq(681)
    expect(character_page.max_ilvl).to eq(695)
  end
end
