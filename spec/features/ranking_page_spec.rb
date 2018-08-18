# frozen_string_literal: true

require 'rails_helper'
require 'support/pages/ranking_page'

# rubocop:disable RSpec/ExampleLength
RSpec.feature 'Ranking page' do
  def ranking_page
    @_page ||= RankingPage.new
  end

  before do
    # Levels need to be > 110 so they are not randomly filtered
    Fabricate(:character, level: 111, name: 'a', region: 'eu', realm: 'shadowmoon', score: 20_000)
    b = Fabricate(:character, level: 111, name: 'b', region: 'eu', realm: 'shadowmoon', score: 20_000)
    top = Fabricate(:character, level: 111, name: 'top', region: 'us', realm: 'illidan', score: 50_000)

    Fabricate(
      :character,
      level: 111,
      region: 'us',
      realm: 'shadowmoon',
      score: 30_000,
      class_name: 'hunter',
      guild_name: 'The Gentlemens Club'
    )

    [b, top].each { |character| Fabricate(:comment, character: character) }
    RecentComment.refresh
  end

  scenario 'User visits realm ranking page' do
    visit characters_path('Us', 'shadowmoon')

    expect(page).to have_title('US-Shadowmoon WoW Character Ranking — WTF is My Gear Score?')

    expect(ranking_page.extra_column_name).to eq('Guild')
    expect(ranking_page.comments.length).to eq(0)

    expect(ranking_page.characters.length).to eq(1)
    expect(ranking_page.characters[0].rank).to eq(1)
    expect(ranking_page.characters[0].score).to eq('30,000')
    expect(ranking_page.characters[0].class_name).to eq('hunter')
    expect(ranking_page.characters[0].extra_column).to eq('The Gentlemens Club')
  end

  scenario 'User visits region ranking page' do
    visit characters_path('eu', per_page: 10)

    expect(page).to have_title('EU WoW Character Ranking — WTF is My Gear Score?')

    expect(ranking_page.extra_column_name).to eq('Realm')
    expect(ranking_page.comments.length).to eq(1)
    expect(ranking_page.characters.length).to eq(2)

    expect(ranking_page.characters[0].rank).to eq(1)
    expect(ranking_page.characters[0].name).to eq('a')
    expect(ranking_page.characters[0].extra_column).to eq('Shadowmoon')

    expect(ranking_page.characters[1].rank).to eq(1)
    expect(ranking_page.characters[1].name).to eq('b')

    expect(ranking_page.next_page?).to eq(false)
    expect(ranking_page.prev_page?).to eq(false)
  end

  scenario 'User visits world ranking page' do
    visit characters_path('world', per_page: 2)

    expect(page).to have_title('World WoW Character Ranking — WTF is My Gear Score?')

    expect(ranking_page.comments.length).to eq(2)

    expect(ranking_page.characters.length).to eq(2)
    expect(ranking_page.characters[0].name).to eq('top')
    expect(ranking_page.characters[0].extra_column).to eq('US-Illidan')
    expect(ranking_page.characters[1].rank).to eq(2)

    ranking_page.next_page

    expect(ranking_page.characters.length).to eq(2)
    expect(ranking_page.characters[0].rank).to eq(3)
    expect(ranking_page.characters[1].rank).to eq(3)

    ranking_page.prev_page

    expect(ranking_page.characters[0].name).to eq('top')
  end
end
# rubocop:enable RSpec/ExampleLength
