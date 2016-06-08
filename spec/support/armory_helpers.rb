# frozen_string_literal: true
# rubocop:disable Metrics/ModuleLength
module ArmoryHelpers
  def stub_character_request
    stub_request(:get, %r{https://us\.api\.battle\.net/wow/character/shadowmoon/dargonaut.+}i)
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
      },
      "items" => {
        "averageItemLevel" => 681,
        "averageItemLevelEquipped" => 681,
        "head" => {
          "id" => 113891,
          "name" => "Blast-Proof Cowl",
          "icon" => "inv_helm_mail_raidshaman_o_01",
          "quality" => 4,
          "itemLevel" => 685
        },
        "neck" => {
          "id" => 113647,
          "name" => "Flechette-Riddled Chain",
          "icon" => "inv_6_0raid_necklace_2c",
          "quality" => 4,
          "itemLevel" => 685
        },
        "shoulder" => {
          "id" => 128351,
          "name" => "Axeclaw Spaulders of the Strategist",
          "icon" => "inv_shoulder_leather_draenorlfr_c_01",
          "quality" => 4,
          "itemLevel" => 695
        },
        "back" => {
          "id" => 119344,
          "name" => "Magic-Breaker Cape",
          "icon" => "inv_cape_draenorraid_d_02_mail_red",
          "quality" => 4,
          "itemLevel" => 670
        },
        "chest" => {
          "id" => 128072,
          "name" => "Bulging Chain Vest",
          "icon" => "inv_chest_mail_draenorhonors2_c_01",
          "quality" => 4,
          "itemLevel" => 685
        },
        "shirt" => {
          "id" => 89194,
          "name" => "Tailored Officer's Shirt",
          "icon" => "inv_shirt03_rare",
          "quality" => 3,
          "itemLevel" => 1
        },
        "wrist" => {
          "id" => 119334,
          "name" => "Bracers of Callous Disregard",
          "icon" => "inv_bracer_mail_raidhunter_o_01",
          "quality" => 4,
          "itemLevel" => 670
        },
        "hands" => {
          "id" => 116190,
          "name" => "Wayfaring Gloves of the Strategist",
          "icon" => "inv_glove_mail_draenorcrafted_d_01_horde",
          "quality" => 4,
          "itemLevel" => 685
        },
        "waist" => {
          "id" => 113827,
          "name" => "Belt of Imminent Lies",
          "icon" => "inv_belt_mail_raidhuntermythic_o_01",
          "quality" => 4,
          "itemLevel" => 685
        },
        "legs" => {
          "id" => 113944,
          "name" => "Legguards of the Stampede",
          "icon" => "inv_pant_mail_raidshaman_o_01",
          "quality" => 4,
          "itemLevel" => 676
        },
        "feet" => {
          "id" => 113849,
          "name" => "Face Kickers",
          "icon" => "inv_boot_mail_raidhuntermythic_o_01",
          "quality" => 4,
          "itemLevel" => 685
        },
        "finger1" => {
          "id" => 113877,
          "name" => "Unexploded Explosive Shard",
          "icon" => "inv_ringwod_d2_4",
          "quality" => 4,
          "itemLevel" => 685
        },
        "finger2" => {
          "id" => 118302,
          "name" => "Spellbound Solium Band of Fatal Strikes",
          "icon" => "inv_misc_6oring_redlv3",
          "quality" => 4,
          "itemLevel" => 690
        },
        "trinket1" => {
          "id" => 113931,
          "name" => "Beating Heart of the Mountain",
          "icon" => "inv_misc_trinket6oih_lanternb3",
          "quality" => 4,
          "itemLevel" => 685
        },
        "trinket2" => {
          "id" => 113612,
          "name" => "Scales of Doom",
          "icon" => "inv_misc_trinket6oog_talisman1",
          "quality" => 4,
          "itemLevel" => 685
        },
        "mainHand" => {
          "id" => 115337,
          "name" => "Formidable Longbow of the Relentless",
          "icon" => "inv_bow_1h_draenorquest_b_01",
          "quality" => 4,
          "itemLevel" => 655
        }
      }
    }
  end

  # This response has dual-wielding for GearscoreCalculatorSpec
  def alternate_character_response_body
    {
      "lastModified" => 1464734765000,
      "name" => "Doubleagent",
      "realm" => "Mannoroth",
      "battlegroup" => "Ruin",
      "class" => 7,
      "race" => 24,
      "gender" => 0,
      "level" => 100,
      "achievementPoints" => 21550,
      "thumbnail" => "mannoroth/49/107725873-avatar.jpg",
      "calcClass" => "W",
      "faction" => 2,
      "totalHonorableKills" => 0,
      "items" => {
        "averageItemLevel" => 457,
        "averageItemLevelEquipped" => 457,
        "head" => {
          "id" => 122246,
          "name" => "Tarnished Raging Berserker's Helm",
          "icon" => "inv_helmet_25",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 137,
          "context" => "",
          "bonusLists" => [583]
        },
        "neck" => {
          "id" => 122668,
          "name" => "Eternal Will of the Martyr",
          "icon" => "inv_jewelry_talisman_07",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 0,
          "context" => "",
          "bonusLists" => [583]
        },
        "shoulder" => {
          "id" => 122356,
          "name" => "Champion Herod's Shoulder",
          "icon" => "inv_shoulder_01",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 126,
          "context" => "",
          "bonusLists" => [583]
        },
        "back" => {
          "id" => 122261,
          "name" => "Inherited Cape of the Black Baron",
          "icon" => "inv_misc_cape_20",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 37,
          "context" => "",
          "bonusLists" => [583]
        },
        "chest" => {
          "id" => 122379,
          "name" => "Champion's Deathdealer Breastplate",
          "icon" => "inv_chest_chain_07",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 168,
          "context" => "",
          "bonusLists" => [583]
        },
        "shirt" => {
          "id" => 4344,
          "name" => "Brown Linen Shirt",
          "icon" => "inv_shirt_02",
          "quality" => 1,
          "itemLevel" => 1,
          "armor" => 0,
          "context" => "",
          "bonusLists" => []
        },
        "wrist" => {
          "id" => 2643,
          "name" => "Loose Chain Bracers",
          "icon" => "inv_bracer_03",
          "quality" => 0,
          "itemLevel" => 10,
          "armor" => 4,
          "context" => "",
          "bonusLists" => []
        },
        "hands" => {
          "id" => 3474,
          "name" => "Gemmed Copper Gauntlets",
          "icon" => "inv_gauntlets_05",
          "quality" => 2,
          "itemLevel" => 15,
          "armor" => 8,
          "context" => "",
          "bonusLists" => []
        },
        "waist" => {
          "id" => 2857,
          "name" => "Runed Copper Belt",
          "icon" => "inv_belt_03",
          "quality" => 2,
          "itemLevel" => 18,
          "armor" => 8,
          "context" => "",
          "bonusLists" => []
        },
        "legs" => {
          "id" => 122252,
          "name" => "Tarnished Leggings of Destruction",
          "icon" => "inv_pants_03",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 147,
          "context" => "",
          "bonusLists" => [583]
        },
        "feet" => {
          "id" => 2309,
          "name" => "Embossed Leather Boots",
          "icon" => "inv_boots_05",
          "quality" => 2,
          "itemLevel" => 15,
          "armor" => 7,
          "context" => "",
          "bonusLists" => []
        },
        "finger1" => {
          "id" => 122529,
          "name" => "Dread Pirate Ring",
          "icon" => "inv_jewelry_ring_39",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 0,
          "context" => "",
          "bonusLists" => [583]
        },
        "finger2" => {
          "id" => 128172,
          "name" => "Captain Sander's Returned Band",
          "icon" => "inv_jewelry_ring_155",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 0,
          "context" => "",
          "bonusLists" => [583]
        },
        "trinket1" => {
          "id" => 122361,
          "name" => "Swift Hand of Justice",
          "icon" => "inv_jewelry_talisman_01",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 0,
          "context" => "",
          "bonusLists" => [583]
        },
        "trinket2" => {
          "id" => 122361,
          "name" => "Swift Hand of Justice",
          "icon" => "inv_jewelry_talisman_01",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 0,
          "context" => "",
          "bonusLists" => [583]
        },
        "mainHand" => {
          "id" => 122396,
          "name" => "Brawler's Razor Claws",
          "icon" => "inv_weapon_hand_21",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 0,
          "context" => "",
          "bonusLists" => [583]
        },
        "offHand" => {
          "id" => 122396,
          "name" => "Brawler's Razor Claws",
          "icon" => "inv_weapon_hand_21",
          "quality" => 7,
          "itemLevel" => 605,
          "armor" => 0,
          "context" => "",
          "bonusLists" => [583]
        }
      }
    }
  end
  # rubocop:enable Metrics/MethodLength, Style/NumericLiterals
end

RSpec.configure do |config|
  config.include ArmoryHelpers
end
