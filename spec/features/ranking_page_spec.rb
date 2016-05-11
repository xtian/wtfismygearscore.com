require 'rails_helper'
require 'support/pages/ranking_page'

RSpec.feature 'Ranking page' do
  def ranking_page
    @_page ||= RankingPage.new
  end

  before do
    Fabricate(:character, name: 'a', region: 'eu', realm: 'shadowmoon', score: 200)
    Fabricate(:character, name: 'b', region: 'eu', realm: 'shadowmoon', score: 200)
    Fabricate(:character, region: 'us', realm: 'shadowmoon', score: 300)
    Fabricate(:character, region: 'us', realm: 'illidan', score: 500)
  end

  scenario 'User visits realm ranking page' do
    visit characters_path('us', 'shadowmoon')

    expect(page).to have_title('US–Shadowmoon WoW Character Ranking — WTF is My Gear Score?')

    expect(ranking_page.characters.length).to eq(1)
    expect(ranking_page.characters[0].rank).to eq(1)
    expect(ranking_page.characters[0].score).to eq(300)
  end

  scenario 'User visits region ranking page' do
    visit characters_path('eu')

    expect(page).to have_title('EU WoW Character Ranking — WTF is My Gear Score?')

    expect(ranking_page.characters.length).to eq(2)

    expect(ranking_page.characters[0].name).to eq('a')
    expect(ranking_page.characters[0].rank).to eq(1)
    expect(ranking_page.characters[0].score).to eq(200)

    expect(ranking_page.characters[1].name).to eq('b')
    expect(ranking_page.characters[1].rank).to eq(1)
  end

  scenario 'User visits world ranking page' do
    visit characters_path('world')

    expect(page).to have_title('World WoW Character Ranking — WTF is My Gear Score?')

    expect(ranking_page.characters.length).to eq(4)

    expect(ranking_page.characters[0].rank).to eq(1)
    expect(ranking_page.characters[1].rank).to eq(2)
    expect(ranking_page.characters[2].rank).to eq(3)
    expect(ranking_page.characters[3].rank).to eq(3)
  end
end
