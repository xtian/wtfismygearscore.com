module ArmoryHelpers
  def stub_character_request
    stub_request(:get, %r{https://.+\.api\.battle\.net/wow/character/.+})
      .to_return(body: character_response_body.to_json)
  end

  # rubocop:disable Metrics/MethodLength, Style/NumericLiterals
  def character_response_body
    {
      "lastModified" => 1436051996000,
      "name" => "Dargonaut",
      "realm" => "Shadowmoon",
      "battlegroup" => "Shadowburn",
      "class" => 3,
      "race" => 4,
      "gender" => 0,
      "level" => 100,
      "achievementPoints" => 7810,
      "thumbnail" => "detheroc/88/129786456-avatar.jpg",
      "calcClass" => "Y",
      "faction" => 0,
      "totalHonorableKills" => 10087,
      "guild" => {
        "name" => "The Gentlemens Club",
        "realm" => "Shadowmoon",
        "battlegroup" => "Shadowburn",
        "members" => 82,
        "achievementPoints" => 890,
        "emblem" => {
          "icon" => 50,
          "iconColor" => "ffdfa55a",
          "border" => 0,
          "borderColor" => "ff672300",
          "backgroundColor" => "ffb1002e"
        }
      }
    }
  end
  # rubocop:enable Metrics/MethodLength, Style/NumericLiterals
end

RSpec.configure do |config|
  config.include ArmoryHelpers
end
