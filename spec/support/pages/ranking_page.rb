# typed: true
# frozen_string_literal: true

require_relative './page'

class RankingPage < Page
  def extra_column_name
    find_tid(:extra_column_name).text
  end

  def characters
    @_characters ||= all_tid(:character).map do |node|
      Character.new(
        rank(node),
        class_name(node),
        name(node),
        extra_column(node),
        score(node)
      )
    end
  end

  def comments
    @_comments ||= all_tid(:comment)
  end

  def next_page
    @_characters = nil
    click_on I18n.t('page.next')
  end

  def next_page?
    page.has_content?(I18n.t('page.next'))
  end

  def prev_page
    @_characters = nil
    click_on I18n.t('page.prev')
  end

  def prev_page?
    page.has_content?(I18n.t('page.prev'))
  end

  private

  def class_name(node)
    node.find_tid(:class_name).text
  end

  def extra_column(node)
    node.find_tid(:extra_column).text
  end

  def name(node)
    node.find_tid(:name).text
  end

  def rank(node)
    node.find_tid(:rank).text.to_i
  end

  def score(node)
    node.find_tid(:score).text
  end

  Character = Struct.new(:rank, :class_name, :name, :extra_column, :score)
end
