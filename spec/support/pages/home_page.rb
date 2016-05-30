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
      name = node.find_tid(:name).text
      body = node.find_tid(:character_name).text
      posted_at = Time.zone.parse(node.find_tid(:posted_at)[:datetime])

      Comment.new(name, body, posted_at)
    end
  end

  Comment = Struct.new(:name, :character_name, :posted_at)
end
