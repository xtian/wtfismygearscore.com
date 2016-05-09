class CharacterPage
  include Capybara::DSL

  def score
    find('[data-t-score]').text.to_i
  end

  def avg_ilvl
    find('[data-t-avg-ilvl]').text.to_i
  end

  def max_ilvl
    find('[data-t-max-ilvl]').text.to_i
  end

  def min_ilvl
    find('[data-t-min-ilvl]').text.to_i
  end
end
