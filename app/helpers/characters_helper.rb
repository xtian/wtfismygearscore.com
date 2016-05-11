module CharactersHelper
  def ranking_title(region, realm)
    region = region.casecmp('world') == 0 ? region.humanize : region.upcase

    [region, realm&.humanize].compact.join('–') + ' WoW Character Ranking'
  end
end
