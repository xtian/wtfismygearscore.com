# frozen_string_literal: true
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
    expect(character_page.faction).to eq('alliance')

    expect(character_page.score).to eq(19_891)
    expect(character_page.min_ilvl).to eq(655)
    expect(character_page.avg_ilvl).to eq(681)
    expect(character_page.max_ilvl).to eq(795)
    expect(character_page.median_difference).to eq(19_891)
    expect(character_page.rating).to eq('win')
  end

  scenario 'User posts a comment' do
    character = Fabricate(:character)
    Fabricate(:comment, body: 'hey', character: character, created_at: 2.weeks.ago)
    Fabricate(:comment, body: 'cool', character: character, created_at: 1.week.ago)

    visit character_path(character, per_page: 2)

    character_page.fill_comment_body 'hi'
    character_page.fill_comment_name 'IdealPoster'

    expect {
      character_page.submit_comment
    }.to have_enqueued_job(CommentPostedJob)

    expect(character_page.notice_message).to eq(I18n.t('comment.posted_successfully'))

    expect(character_page.comments_count).to eq(3)
    expect(character_page.comments.length).to eq(2)

    expect(character_page.comments[0].body).to eq('hi')
    expect(character_page.comments[0].name).to eq('IdealPoster')

    expect(character_page.comments[1].body).to eq('cool')
    expect(character_page.comments[1].name).to eq('Anonymous')
    expect(character_page.comments[1].posted_at).to eq(1.week.ago.to_date)

    expect(character_page.prev_page?).to eq(false)
    character_page.next_page

    expect(character_page.comments.length).to eq(1)
    expect(character_page.comments[0].body).to eq('hey')

    expect(character_page.next_page?).to eq(false)
    character_page.prev_page

    expect(character_page.comments[0].body).to eq('hi')
  end
end
