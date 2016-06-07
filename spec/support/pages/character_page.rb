# frozen_string_literal: true
require_relative './page'

class CharacterPage < Page
  def guild_name
    find_tid(:guild_name).text
  end

  def score
    find_tid(:score).text.to_i
  end

  def avg_ilvl
    find_tid(:avg_ilvl).text.to_i
  end

  def max_ilvl
    find_tid(:max_ilvl).text.to_i
  end

  def min_ilvl
    find_tid(:min_ilvl).text.to_i
  end

  def fill_comment_body(value)
    fill_in 'Comment', with: value
  end

  def fill_comment_name(value)
    fill_in 'Name', with: value
  end

  def submit_comment
    click_on 'Post'
  end

  def comments
    @_comments ||= all_tid(:comment).map do |node|
      name = node.find_tid(:name).text
      body = node.find_tid(:body).text
      posted_at = Date.parse(node.find_tid(:posted_at)[:datetime])

      Comment.new(name, body, posted_at)
    end
  end

  Comment = Struct.new(:name, :body, :posted_at)
end
