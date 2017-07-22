# frozen_string_literal: true

require_relative './page'

class CharacterPage < Page
  %i[avg_ilvl comments_count max_ilvl min_ilvl].each do |key|
    define_method key do
      find_tid(key).text.to_i
    end
  end

  %i[guild_name median_difference rating realm score].each do |key|
    define_method key do
      find_tid(key).text
    end
  end

  def faction
    return 'alliance' if page.has_selector?('.is-alliance')
    'horde' if page.has_selector?('.is-horde')
  end

  def next_page
    @_comments = nil
    click_on I18n.t('page.next')
  end

  def next_page?
    page.has_content?(I18n.t('page.next'))
  end

  def prev_page
    @_comments = nil
    click_on I18n.t('page.prev')
  end

  def prev_page?
    page.has_content?(I18n.t('page.prev'))
  end

  def fill_comment_body(value)
    fill_in 'Comment', with: value
  end

  def fill_comment_name(value)
    fill_in 'Name (optional)', with: value
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
