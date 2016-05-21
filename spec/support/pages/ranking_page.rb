require_relative './page'

class RankingPage < Page
  def characters
    @_characters ||= all_tid(:character).map do |node|
      rank = node.find_tid(:rank).text.to_i
      name = node.find_tid(:name).text
      score = node.find_tid(:score).text.to_i

      Character.new(rank, name, score)
    end
  end

  Character = Struct.new(:rank, :name, :score)
end
