# frozen_string_literal: true

require "rails_helper"
require "support/armory_helpers"
require "support/pages/home_page"

RSpec.feature "Homepage" do
  def home_page
    HomePage.new
  end

  scenario "User visits homepage" do
    comments = Array.new(6).map { Fabricate(:comment) }
    RecentComment.refresh

    visit root_path

    expect(page).to have_title("WTF is My Gear Score?")
    expect(page).to have_css('script[src="https://www.google-analytics.com/analytics.js"]', visible: false, count: 1)

    expect(home_page.comments.length).to eq(5)

    first_comment = home_page.comments[0]
    expect(first_comment.name).to eq("Anonymous")
    expect(first_comment.posted_at).to be_within(1.second).of(comments[0].created_at)
    expect(first_comment.character_name).not_to be_nil
  end

  context "when submitting redirect form" do
    before do
      stub_character_request
      visit root_path
    end

    scenario "User submits character info" do
      home_page.fill_name "Dargonaut"
      home_page.fill_realm "Shadowmoon"
      home_page.submit

      expect(page).to have_current_path(character_path("us", "Shadowmoon", "Dargonaut"))
    end

    scenario "User submits realm info" do
      home_page.fill_realm "Shadowmoon"
      home_page.submit

      expect(page).to have_current_path(characters_path("us", "Shadowmoon"))
    end

    scenario "User submits region info" do
      home_page.fill_region "EU"
      home_page.submit

      expect(page).to have_current_path(characters_path("eu"))
    end
  end
end
