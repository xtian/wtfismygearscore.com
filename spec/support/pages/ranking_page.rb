class RankingPage
  include Capybara::DSL

  def characters
    @_characters ||= all('[data-t-character]').map do |node|
      rank = node.find('[data-t-rank]').text.to_i
      name = node.find('[data-t-name]').text
      score = node.find('[data-t-score]').text.to_i

      Character.new(rank, name, score)
    end
  end

  Character = Struct.new(:rank, :name, :score)
end
