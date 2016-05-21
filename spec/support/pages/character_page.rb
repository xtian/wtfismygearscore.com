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
end
