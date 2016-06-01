require_relative './page'

class RankingPage < Page
  def extra_column_name
    find_tid(:extra_column_name).text
  end

  def characters
    @_characters ||= all_tid(:character).map do |node|
      rank = node.find_tid(:rank).text.to_i
      name = node.find_tid(:name).text
      score = node.find_tid(:score).text.to_i
      extra_column = node.find_tid(:extra_column).text

      Character.new(rank, name, score, extra_column)
    end
  end

  Character = Struct.new(:rank, :name, :score, :extra_column)
end
