# typed: true
# frozen_string_literal: true

require_relative './page'

class HomePage < Page
  def fill_region(value)
    select value, from: 'Region'
  end

  def fill_realm(value)
    fill_in 'Realm', with: value
  end

  def fill_name(value)
    fill_in 'Character Name', with: value
  end

  def submit
    click_on 'Score Me!'
  end

  def comments
    @_comments ||= all_tid(:comment).map do |node|
      Comment.new(name(node), character_name(node), posted_at(node))
    end
  end

  private

  Comment = Struct.new(:name, :character_name, :posted_at)

  def character_name(node)
    node.find_tid(:character_name).text
  end

  def name(node)
    node.find_tid(:name).text
  end

  def posted_at(node)
    Time.zone.parse(node.find_tid(:posted_at)[:datetime])
  end
end
