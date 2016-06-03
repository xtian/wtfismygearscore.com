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
      "lastModified" => 1410641389000,
      "name" => "Hunghuaylo",
      "realm" => "Shadowmoon",
      "battlegroup" => "Shadowburn",
      "class" => 1,
      "race" => 1,
      "gender" => 0,
      "level" => 90,
      "achievementPoints" => 7395,
      "thumbnail" => "detheroc/98/129048930-avatar.jpg",
      "calcClass" => "Z",
      "faction" => 0,
      "totalHonorableKills" => 6369,
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
        "averageItemLevel" => 539,
        "averageItemLevelEquipped" => 539,
        "head" => {
          "id" => 104959,
          "name" => "Rage-Blind Greathelm",
          "icon" => "inv_helmet_plate_raiddeathknight_n_01",
          "quality" => 4,
          "itemLevel" => 528
        },
        "neck" => {
          "id" => 104733,
          "name" => "Choker of the Final Word",
          "icon" => "inv_misc_necklace_mop1",
          "quality" => 4,
          "itemLevel" => 548
        },
        "shoulder" => {
          "id" => 99030,
          "name" => "Shoulderguards of the Prehistoric Marauder",
          "icon" => "inv_shoulder_plate_raidwarrior_n_01",
          "quality" => 4,
          "itemLevel" => 536
        },
        "back" => {
          "id" => 101939,
          "name" => "Elder Tortoiseshell Drape of the Savant",
          "icon" => "inv_cape_pandaria_c_04",
          "quality" => 4,
          "itemLevel" => 543
        },
        "chest" => {
          "id" => 101938,
          "name" => "Elder Tortoiseshell Breastplate of the Bladewall",
          "icon" => "inv_chest_plate_reputation_c_01",
          "quality" => 4,
          "itemLevel" => 543
        },
        "wrist" => {
          "id" => 104991,
          "name" => "Arcsmasher Bracers",
          "icon" => "inv_plate_raidpaladin_n_01bracer",
          "quality" => 4,
          "itemLevel" => 528
        },
        "hands" => {
          "id" => 104937,
          "name" => "Shockstriker Gauntlets",
          "icon" => "inv_gauntlet_plate_raidwarrior_n_01",
          "quality" => 4,
          "itemLevel" => 536
        },
        "waist" => {
          "id" => 98615,
          "name" => "Protector's Trillium Waistguard",
          "icon" => "inv_belt_93",
          "quality" => 4,
          "itemLevel" => 553
        },
        "legs" => {
          "id" => 98606,
          "name" => "Protector's Trillium Legguards",
          "icon" => "inv_pants_plate_40",
          "quality" => 4,
          "itemLevel" => 561
        },
        "feet" => {
          "id" => 104667,
          "name" => "Treads of Unchained Hate",
          "icon" => "inv_boots_plate_raiddeathknight_n_01",
          "quality" => 4,
          "itemLevel" => 548
        },
        "finger1" => {
          "id" => 101947,
          "name" => "Elder Tortoiseshell Seal of the Mountainbed",
          "icon" => "inv_jewelry_ring_154",
          "quality" => 4,
          "itemLevel" => 535
        },
        "finger2" => {
          "id" => 95141,
          "name" => "Loop of the Shado-Pan Assault",
          "icon" => "inv_jewelry_ring_165",
          "quality" => 4,
          "itemLevel" => 522
        },
        "trinket1" => {
          "id" => 105016,
          "name" => "Juggernaut's Focusing Crystal",
          "icon" => "inv_jewelry_orgrimmarraid_trinket_19",
          "quality" => 4,
          "itemLevel" => 536
        },
        "trinket2" => {
          "id" => 103990,
          "name" => "Resolve of Niuzao",
          "icon" => "inv_pet_yakgod",
          "quality" => 4,
          "itemLevel" => 543
        },
        "mainHand" => {
          "id" => 104962,
          "name" => "Xifeng, Longblade of the Titanic Guardian",
          "icon" => "inv_sword_1h_orgrimmarraid_d_01",
          "quality" => 4,
          "itemLevel" => 536
        },
        "offHand" => {
          "id" => 104983,
          "name" => "Shield of Mockery",
          "icon" => "inv_shield_orgrimmarraid_d_01",
          "quality" => 4,
          "itemLevel" => 536
        }
      }
    }
  end
  # rubocop:enable Metrics/MethodLength, Style/NumericLiterals
end

RSpec.configure do |config|
  config.include ArmoryHelpers
end
