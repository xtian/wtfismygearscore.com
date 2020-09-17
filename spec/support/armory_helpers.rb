# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module ArmoryHelpers
  def stub_character_request(name: "dargonaut", client_id: nil, client_secret: nil)
    access_token = "not-an-access-token"
    stub_token_request(access_token, client_id, client_secret)

    profile_url = %r{
      https://us\.api\.blizzard\.com/profile/wow/character/shadowmoon/#{name}
      \?access_token=#{access_token}
      &locale=en_US
      &namespace=profile-us
    }ix

    stub_request(:get, profile_url).to_return(body: profile_response_body.to_json)

    equipment_url = %r{
      https://us\.api\.blizzard\.com/profile/wow/character/shadowmoon/#{name}/equipment
      \?access_token=#{access_token}
      &locale=en_US
      &namespace=profile-us
    }ix

    stub_request(:get, equipment_url).to_return(body: equipment_response_body.to_json)
  end

  def stub_token_request(access_token, client_id, client_secret)
    client_id ||= Rails.application.secrets.blizzard_client_id
    client_secret ||= Rails.application.secrets.blizzard_client_secret

    token_url = %r{
      https://us\.battle\.net/oauth/token
      \?client_id=#{client_id}
      &client_secret=#{client_secret}
      &grant_type=client_credentials
    }ix

    token_response_body = { access_token: access_token, expires_in: 1.day.to_i }
    stub_request(:post, token_url).to_return(body: token_response_body.to_json)
  end

  # rubocop:disable Metrics/MethodLength, Style/NumericLiterals
  def equipment_response_body
    {
      "_links" => {
        "self" => {
          "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/equipment?namespace=profile-us",
        },
      },
      "character" => {
        "key" => {
          "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut?namespace=profile-us",
        },
        "name" => "Dargonaut",
        "id" => 129786456,
        "realm" => {
          "key" => {
            "href" => "https://us.api.blizzard.com/data/wow/realm/94?namespace=dynamic-us",
          },
          "name" => "Shadowmoon",
          "id" => 94,
          "slug" => "shadowmoon",
        },
      },
      "equipped_items" => [
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/155887?namespace=static-8.2.5_31884-us",
            },
            "id" => 155887,
          },
          "slot" => {
            "type" => "HEAD",
            "name" => "Head",
          },
          "quantity" => 1,
          "context" => 35,
          "bonus_list" => [
            5044,
            1527,
            4786,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Sweete's Jeweled Headgear",
          "modified_appearance_id" => 95833,
          "azerite_details" => {
            "selected_powers" => [
              {
                "id" => 0,
                "tier" => 0,
              },
              {
                "id" => 0,
                "tier" => 1,
              },
              {
                "id" => 22,
                "tier" => 2,
                "spell_tooltip" => {
                  "spell" => {
                    "key" => {
                      "href" => "https://us.api.blizzard.com/data/wow/spell/263987?namespace=static-8.2.5_31884-us",
                    },
                    "name" => "Heed My Call",
                    "id" => 263987,
                  },
                  "description" => "Your damaging abilities have a chance to deal 2,806 Nature damage to your target, and 1,203 Nature damage to enemies within 3 yards of that target.",
                  "cast_time" => "Passive",
                },
              },
              {
                "id" => 505,
                "tier" => 3,
                "spell_tooltip" => {
                  "spell" => {
                    "key" => {
                      "href" => "https://us.api.blizzard.com/data/wow/spell/281841?namespace=static-8.2.5_31884-us",
                    },
                    "name" => "Tradewinds",
                    "id" => 281841,
                  },
                  "description" => "Your spells and abilities have a chance to grant you 717 Mastery for 15 sec. When this effect expires it jumps once to a nearby ally, granting them 142 Mastery for 8 sec.",
                  "cast_time" => "Passive",
                },
              },
            ],
            "selected_powers_string" => "Active Azerite Powers (2/4):",
          },
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/155887?namespace=static-8.2.5_31884-us",
            },
            "id" => 155887,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/3?namespace=static-8.2.5_31884-us",
            },
            "name" => "Mail",
            "id" => 3,
          },
          "inventory_type" => {
            "type" => "HEAD",
            "name" => "Head",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "armor" => {
            "value" => 305,
            "display_string" => "305 Armor",
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 472,
              "display_string" => "+472 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 472,
              "display_string" => "+472 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 818,
              "display_string" => "+818 Stamina",
            },
          ],
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 355,
            "display_string" => "Item Level 355",
          },
          "transmog" => {
            "item" => {
              "key" => {
                "href" => "https://us.api.blizzard.com/data/wow/item/134110?namespace=static-8.2.5_31884-us",
              },
              "name" => "Hidden Helm",
              "id" => 134110,
            },
            "display_string" => "Transmogrified to:\nHidden Helm",
            "item_modified_appearance_id" => 77344,
          },
          "durability" => {
            "value" => 100,
            "display_string" => "Durability 100 / 100",
          },
          "name_description" => {
            "display_string" => "Mythic 4",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/158075?namespace=static-8.2.5_31884-us",
            },
            "id" => 158075,
          },
          "slot" => {
            "type" => "NECK",
            "name" => "Neck",
          },
          "quantity" => 1,
          "context" => 11,
          "bonus_list" => [
            4932,
            4933,
            4936,
          ],
          "quality" => {
            "type" => "ARTIFACT",
            "name" => "Artifact",
          },
          "name" => "Heart of Azeroth",
          "azerite_details" => {
            "percentage_to_next_level" => 0.055,
            "level" => {
              "value" => 22,
              "display_string" => "Azerite Power Level 22",
            },
          },
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/158075?namespace=static-8.2.5_31884-us",
            },
            "id" => 158075,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/0?namespace=static-8.2.5_31884-us",
            },
            "name" => "Miscellaneous",
            "id" => 0,
          },
          "inventory_type" => {
            "type" => "NECK",
            "name" => "Neck",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "unique_equipped" => "Unique",
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 118,
              "display_string" => "+118 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 118,
              "display_string" => "+118 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STRENGTH",
                "name" => "Strength",
              },
              "value" => 118,
              "display_string" => "+118 Strength",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 188,
              "display_string" => "+188 Stamina",
            },
            {
              "type" => {
                "type" => "CRIT_RATING",
                "name" => "Critical Strike",
              },
              "value" => 199,
              "display_string" => "+199 Critical Strike",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "HASTE_RATING",
                "name" => "Haste",
              },
              "value" => 199,
              "display_string" => "+199 Haste",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "MASTERY_RATING",
                "name" => "Mastery",
              },
              "value" => 199,
              "display_string" => "+199 Mastery",
              "is_equip_bonus" => true,
            },
          ],
          "spells" => [
            {
              "spell" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/spell/277253?namespace=static-8.2.5_31884-us",
                },
                "name" => "Heart of Azeroth",
                "id" => 277253,
              },
              "description" => "Equip: Harnesses the energy of raw Azerite, awakening exceptional pieces of armor that possess latent powers.",
            },
          ],
          "requirements" => {
            "level" => {
              "value" => 110,
              "display_string" => "Requires Level 110",
            },
          },
          "description" => "A living symbol of hope, borne by the champions of a dying planet. The fate of Azeroth will be shared by all her children.",
          "level" => {
            "value" => 337,
            "display_string" => "Item Level 337",
          },
          "is_subclass_hidden" => true,
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/158019?namespace=static-8.2.5_31884-us",
            },
            "id" => 158019,
          },
          "slot" => {
            "type" => "SHOULDER",
            "name" => "Shoulders",
          },
          "quantity" => 1,
          "context" => 28,
          "bonus_list" => [
            1532,
            5140,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Ashenwood Spaulders",
          "azerite_details" => {
            "selected_powers" => [
              {
                "id" => 0,
                "tier" => 0,
              },
              {
                "id" => 15,
                "tier" => 1,
                "spell_tooltip" => {
                  "spell" => {
                    "key" => {
                      "href" => "https://us.api.blizzard.com/data/wow/spell/263962?namespace=static-8.2.5_31884-us",
                    },
                    "name" => "Resounding Protection",
                    "id" => 263962,
                  },
                  "description" => "Every 30 sec, gain an absorb shield for 8,163 for 30 sec.",
                  "cast_time" => "Passive",
                },
              },
              {
                "id" => 22,
                "tier" => 2,
                "spell_tooltip" => {
                  "spell" => {
                    "key" => {
                      "href" => "https://us.api.blizzard.com/data/wow/spell/263987?namespace=static-8.2.5_31884-us",
                    },
                    "name" => "Heed My Call",
                    "id" => 263987,
                  },
                  "description" => "Your damaging abilities have a chance to deal 2,806 Nature damage to your target, and 1,203 Nature damage to enemies within 3 yards of that target.",
                  "cast_time" => "Passive",
                },
              },
              {
                "id" => 193,
                "tier" => 3,
                "spell_tooltip" => {
                  "spell" => {
                    "key" => {
                      "href" => "https://us.api.blizzard.com/data/wow/spell/273823?namespace=static-8.2.5_31884-us",
                    },
                    "name" => "Blightborne Infusion",
                    "id" => 273823,
                  },
                  "description" => "Your spells and abilities have a chance to draw a Wandering Soul from Thros to serve you for 14 sec. The Soul increases your Critical Strike by 944.",
                  "cast_time" => "Passive",
                },
              },
            ],
            "selected_powers_string" => "Active Azerite Powers (3/4):",
          },
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/158019?namespace=static-8.2.5_31884-us",
            },
            "id" => 158019,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/3?namespace=static-8.2.5_31884-us",
            },
            "name" => "Mail",
            "id" => 3,
          },
          "inventory_type" => {
            "type" => "SHOULDER",
            "name" => "Shoulder",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "armor" => {
            "value" => 257,
            "display_string" => "257 Armor",
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 308,
              "display_string" => "+308 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 308,
              "display_string" => "+308 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 523,
              "display_string" => "+523 Stamina",
            },
          ],
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 340,
            "display_string" => "Item Level 340",
          },
          "durability" => {
            "value" => 100,
            "display_string" => "Durability 100 / 100",
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/89194?namespace=static-8.2.5_31884-us",
            },
            "id" => 89194,
          },
          "slot" => {
            "type" => "SHIRT",
            "name" => "Shirt",
          },
          "quantity" => 1,
          "quality" => {
            "type" => "RARE",
            "name" => "Rare",
          },
          "name" => "Tailored Officer's Shirt",
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/89194?namespace=static-8.2.5_31884-us",
            },
            "id" => 89194,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/0?namespace=static-8.2.5_31884-us",
            },
            "name" => "Miscellaneous",
            "id" => 0,
          },
          "inventory_type" => {
            "type" => "BODY",
            "name" => "Shirt",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "sell_price" => {
            "value" => 300000,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "30",
              "silver" => "0",
              "copper" => "0",
            },
          },
          "level" => {
            "value" => 1,
            "display_string" => "Item Level 1",
          },
          "transmog" => {
            "item" => {
              "key" => {
                "href" => "https://us.api.blizzard.com/data/wow/item/11840?namespace=static-8.2.5_31884-us",
              },
              "name" => "Master Builder's Shirt",
              "id" => 11840,
            },
            "display_string" => "Transmogrified to:\nMaster Builder's Shirt",
            "item_modified_appearance_id" => 4268,
          },
          "is_subclass_hidden" => true,
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/161469?namespace=static-8.2.5_31884-us",
            },
            "id" => 161469,
          },
          "slot" => {
            "type" => "CHEST",
            "name" => "Chest",
          },
          "quantity" => 1,
          "context" => 3,
          "bonus_list" => [
            5120,
            1492,
            4786,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Sharpshooter's Chainmail Hauberk",
          "modified_appearance_id" => 97409,
          "azerite_details" => {
            "selected_powers" => [
              {
                "id" => 0,
                "tier" => 0,
              },
              {
                "id" => 0,
                "tier" => 1,
              },
              {
                "id" => 30,
                "tier" => 2,
                "spell_tooltip" => {
                  "spell" => {
                    "key" => {
                      "href" => "https://us.api.blizzard.com/data/wow/spell/266180?namespace=static-8.2.5_31884-us",
                    },
                    "name" => "Overwhelming Power",
                    "id" => 266180,
                  },
                  "description" => "Your damaging abilities have a chance to grant you 25 applications of Overwhelming Power. Each stack of Overwhelming Power grants 20 Haste. An application of Overwhelming Power is removed every 1 sec or whenever you take damage.",
                  "cast_time" => "Passive",
                },
              },
              {
                "id" => 366,
                "tier" => 3,
                "spell_tooltip" => {
                  "spell" => {
                    "key" => {
                      "href" => "https://us.api.blizzard.com/data/wow/spell/279806?namespace=static-8.2.5_31884-us",
                    },
                    "name" => "Primal Instincts",
                    "id" => 279806,
                  },
                  "description" => "Aspect of the Wild increases your Mastery by 771, and grants you a charge of Barbed Shot.",
                  "cast_time" => "Passive",
                },
              },
            ],
            "selected_powers_string" => "Active Azerite Powers (2/4):",
          },
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/161469?namespace=static-8.2.5_31884-us",
            },
            "id" => 161469,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/3?namespace=static-8.2.5_31884-us",
            },
            "name" => "Mail",
            "id" => 3,
          },
          "inventory_type" => {
            "type" => "CHEST",
            "name" => "Chest",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "armor" => {
            "value" => 413,
            "display_string" => "413 Armor",
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 543,
              "display_string" => "+543 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 543,
              "display_string" => "+543 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 960,
              "display_string" => "+960 Stamina",
            },
          ],
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 370,
            "display_string" => "Item Level 370",
          },
          "durability" => {
            "value" => 165,
            "display_string" => "Durability 165 / 165",
          },
          "name_description" => {
            "display_string" => "Heroic",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/161394?namespace=static-8.2.5_31884-us",
            },
            "id" => 161394,
          },
          "slot" => {
            "type" => "WAIST",
            "name" => "Waist",
          },
          "quantity" => 1,
          "context" => 3,
          "bonus_list" => [
            4798,
            1487,
            4783,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Hurricane Cinch",
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/161394?namespace=static-8.2.5_31884-us",
            },
            "id" => 161394,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/3?namespace=static-8.2.5_31884-us",
            },
            "name" => "Mail",
            "id" => 3,
          },
          "inventory_type" => {
            "type" => "WAIST",
            "name" => "Waist",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "armor" => {
            "value" => 225,
            "display_string" => "225 Armor",
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 205,
              "display_string" => "+205 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 205,
              "display_string" => "+205 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 337,
              "display_string" => "+337 Stamina",
            },
            {
              "type" => {
                "type" => "CRIT_RATING",
                "name" => "Critical Strike",
              },
              "value" => 62,
              "display_string" => "+62 Critical Strike",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "MASTERY_RATING",
                "name" => "Mastery",
              },
              "value" => 106,
              "display_string" => "+106 Mastery",
              "is_equip_bonus" => true,
            },
          ],
          "sell_price" => {
            "value" => 347970,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "34",
              "silver" => "79",
              "copper" => "70",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 365,
            "display_string" => "Item Level 365",
          },
          "durability" => {
            "value" => 55,
            "display_string" => "Durability 55 / 55",
          },
          "name_description" => {
            "display_string" => "Warforged",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/161393?namespace=static-8.2.5_31884-us",
            },
            "id" => 161393,
          },
          "slot" => {
            "type" => "LEGS",
            "name" => "Legs",
          },
          "quantity" => 1,
          "context" => 3,
          "bonus_list" => [
            4798,
            1477,
            4786,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Legguards of the Barkbound Dead",
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/161393?namespace=static-8.2.5_31884-us",
            },
            "id" => 161393,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/3?namespace=static-8.2.5_31884-us",
            },
            "name" => "Mail",
            "id" => 3,
          },
          "inventory_type" => {
            "type" => "LEGS",
            "name" => "Legs",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "armor" => {
            "value" => 328,
            "display_string" => "328 Armor",
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 248,
              "display_string" => "+248 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 248,
              "display_string" => "+248 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 403,
              "display_string" => "+403 Stamina",
            },
            {
              "type" => {
                "type" => "VERSATILITY",
                "name" => "Versatility",
              },
              "value" => 84,
              "display_string" => "+84 Versatility",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "MASTERY_RATING",
                "name" => "Mastery",
              },
              "value" => 131,
              "display_string" => "+131 Mastery",
              "is_equip_bonus" => true,
            },
          ],
          "sell_price" => {
            "value" => 683034,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "68",
              "silver" => "30",
              "copper" => "34",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 355,
            "display_string" => "Item Level 355",
          },
          "durability" => {
            "value" => 120,
            "display_string" => "Durability 120 / 120",
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/158015?namespace=static-8.2.5_31884-us",
            },
            "id" => 158015,
          },
          "slot" => {
            "type" => "FEET",
            "name" => "Feet",
          },
          "quantity" => 1,
          "context" => 27,
          "bonus_list" => [
            4803,
            1532,
            4783,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Ashenwood Sabatons",
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/158015?namespace=static-8.2.5_31884-us",
            },
            "id" => 158015,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/3?namespace=static-8.2.5_31884-us",
            },
            "name" => "Mail",
            "id" => 3,
          },
          "inventory_type" => {
            "type" => "FEET",
            "name" => "Feet",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "armor" => {
            "value" => 235,
            "display_string" => "235 Armor",
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 162,
              "display_string" => "+162 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 162,
              "display_string" => "+162 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 258,
              "display_string" => "+258 Stamina",
            },
            {
              "type" => {
                "type" => "HASTE_RATING",
                "name" => "Haste",
              },
              "value" => 71,
              "display_string" => "+71 Haste",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "MASTERY_RATING",
                "name" => "Mastery",
              },
              "value" => 78,
              "display_string" => "+78 Mastery",
              "is_equip_bonus" => true,
            },
          ],
          "sell_price" => {
            "value" => 527724,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "52",
              "silver" => "77",
              "copper" => "24",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 340,
            "display_string" => "Item Level 340",
          },
          "durability" => {
            "value" => 80,
            "display_string" => "Durability 80 / 80",
          },
          "name_description" => {
            "display_string" => "Warforged",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/160629?namespace=static-8.2.5_31884-us",
            },
            "id" => 160629,
          },
          "slot" => {
            "type" => "WRIST",
            "name" => "Wrist",
          },
          "quantity" => 1,
          "context" => 3,
          "bonus_list" => [
            4798,
            1477,
            4786,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Rubywrought Sparkguards",
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/160629?namespace=static-8.2.5_31884-us",
            },
            "id" => 160629,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/3?namespace=static-8.2.5_31884-us",
            },
            "name" => "Mail",
            "id" => 3,
          },
          "inventory_type" => {
            "type" => "WRIST",
            "name" => "Wrist",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "armor" => {
            "value" => 164,
            "display_string" => "164 Armor",
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 140,
              "display_string" => "+140 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 140,
              "display_string" => "+140 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 227,
              "display_string" => "+227 Stamina",
            },
            {
              "type" => {
                "type" => "HASTE_RATING",
                "name" => "Haste",
              },
              "value" => 68,
              "display_string" => "+68 Haste",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "MASTERY_RATING",
                "name" => "Mastery",
              },
              "value" => 52,
              "display_string" => "+52 Mastery",
              "is_equip_bonus" => true,
            },
          ],
          "sell_price" => {
            "value" => 352724,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "35",
              "silver" => "27",
              "copper" => "24",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 355,
            "display_string" => "Item Level 355",
          },
          "durability" => {
            "value" => 55,
            "display_string" => "Durability 55 / 55",
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/158016?namespace=static-8.2.5_31884-us",
            },
            "id" => 158016,
          },
          "slot" => {
            "type" => "HANDS",
            "name" => "Hands",
          },
          "quantity" => 1,
          "context" => 27,
          "bonus_list" => [
            4803,
            1537,
            4784,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Ashenwood Gauntlets",
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/158016?namespace=static-8.2.5_31884-us",
            },
            "id" => 158016,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/3?namespace=static-8.2.5_31884-us",
            },
            "name" => "Mail",
            "id" => 3,
          },
          "inventory_type" => {
            "type" => "HAND",
            "name" => "Hands",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "armor" => {
            "value" => 220,
            "display_string" => "220 Armor",
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 170,
              "display_string" => "+170 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 170,
              "display_string" => "+170 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 272,
              "display_string" => "+272 Stamina",
            },
            {
              "type" => {
                "type" => "CRIT_RATING",
                "name" => "Critical Strike",
              },
              "value" => 84,
              "display_string" => "+84 Critical Strike",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "HASTE_RATING",
                "name" => "Haste",
              },
              "value" => 70,
              "display_string" => "+70 Haste",
              "is_equip_bonus" => true,
            },
          ],
          "sell_price" => {
            "value" => 357440,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "35",
              "silver" => "74",
              "copper" => "40",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 345,
            "display_string" => "Item Level 345",
          },
          "durability" => {
            "value" => 55,
            "display_string" => "Durability 55 / 55",
          },
          "name_description" => {
            "display_string" => "Titanforged",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/158314?namespace=static-8.2.5_31884-us",
            },
            "id" => 158314,
          },
          "slot" => {
            "type" => "FINGER_1",
            "name" => "Ring 1",
          },
          "quantity" => 1,
          "context" => 16,
          "bonus_list" => [
            5002,
            1522,
            4786,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Seal of Questionable Loyalties",
          "modified_appearance_id" => 0,
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/158314?namespace=static-8.2.5_31884-us",
            },
            "id" => 158314,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/0?namespace=static-8.2.5_31884-us",
            },
            "name" => "Miscellaneous",
            "id" => 0,
          },
          "inventory_type" => {
            "type" => "FINGER",
            "name" => "Finger",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "unique_equipped" => "Unique-Equipped",
          "stats" => [
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 215,
              "display_string" => "+215 Stamina",
            },
            {
              "type" => {
                "type" => "CRIT_RATING",
                "name" => "Critical Strike",
              },
              "value" => 116,
              "display_string" => "+116 Critical Strike",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "HASTE_RATING",
                "name" => "Haste",
              },
              "value" => 254,
              "display_string" => "+254 Haste",
              "is_equip_bonus" => true,
            },
          ],
          "sell_price" => {
            "value" => 435419,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "43",
              "silver" => "54",
              "copper" => "19",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 350,
            "display_string" => "Item Level 350",
          },
          "is_subclass_hidden" => true,
          "name_description" => {
            "display_string" => "Mythic 4",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/159463?namespace=static-8.2.5_31884-us",
            },
            "id" => 159463,
          },
          "enchantments" => [
            {
              "display_string" => "Enchanted: +30 Haste",
              "source_item" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/item/153439?namespace=static-8.2.5_31884-us",
                },
                "name" => "Enchant Ring - Seal of Haste",
                "id" => 153439,
              },
              "enchantment_id" => 5939,
              "enchantment_slot" => {
                "id" => 0,
                "type" => "PERMANENT",
              },
            },
          ],
          "sockets" => [
            {
              "socket_type" => {
                "type" => "PRISMATIC",
                "name" => "Prismatic Socket",
              },
              "item" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/item/154127?namespace=static-8.2.5_31884-us",
                },
                "name" => "Quick Owlseye",
                "id" => 154127,
              },
              "display_string" => "+40 Haste",
              "media" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/media/item/154127?namespace=static-8.2.5_31884-us",
                },
                "id" => 154127,
              },
            },
          ],
          "slot" => {
            "type" => "FINGER_2",
            "name" => "Ring 2",
          },
          "quantity" => 1,
          "context" => 35,
          "bonus_list" => [
            5005,
            4802,
            1532,
            4783,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Loop of Pulsing Veins",
          "modified_appearance_id" => 0,
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/159463?namespace=static-8.2.5_31884-us",
            },
            "id" => 159463,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/0?namespace=static-8.2.5_31884-us",
            },
            "name" => "Miscellaneous",
            "id" => 0,
          },
          "inventory_type" => {
            "type" => "FINGER",
            "name" => "Finger",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "unique_equipped" => "Unique-Equipped",
          "stats" => [
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 238,
              "display_string" => "+238 Stamina",
            },
            {
              "type" => {
                "type" => "HASTE_RATING",
                "name" => "Haste",
              },
              "value" => 236,
              "display_string" => "+236 Haste",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "MASTERY_RATING",
                "name" => "Mastery",
              },
              "value" => 150,
              "display_string" => "+150 Mastery",
              "is_equip_bonus" => true,
            },
          ],
          "sell_price" => {
            "value" => 449738,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "44",
              "silver" => "97",
              "copper" => "38",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 360,
            "display_string" => "Item Level 360",
          },
          "is_subclass_hidden" => true,
          "name_description" => {
            "display_string" => "Mythic 5 Warforged",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/158374?namespace=static-8.2.5_31884-us",
            },
            "id" => 158374,
          },
          "sockets" => [
            {
              "socket_type" => {
                "type" => "PRISMATIC",
                "name" => "Prismatic Socket",
              },
              "item" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/item/153711?namespace=static-8.2.5_31884-us",
                },
                "name" => "Quick Golden Beryl",
                "id" => 153711,
              },
              "display_string" => "+30 Haste",
              "media" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/media/item/153711?namespace=static-8.2.5_31884-us",
                },
                "id" => 153711,
              },
            },
          ],
          "slot" => {
            "type" => "TRINKET_1",
            "name" => "Trinket 1",
          },
          "quantity" => 1,
          "context" => 2,
          "bonus_list" => [
            4778,
            4802,
            1497,
            4785,
          ],
          "quality" => {
            "type" => "RARE",
            "name" => "Rare",
          },
          "name" => "Tiny Electromental in a Jar",
          "modified_appearance_id" => 0,
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/158374?namespace=static-8.2.5_31884-us",
            },
            "id" => 158374,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/0?namespace=static-8.2.5_31884-us",
            },
            "name" => "Miscellaneous",
            "id" => 0,
          },
          "inventory_type" => {
            "type" => "TRINKET",
            "name" => "Trinket",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "unique_equipped" => "Unique-Equipped",
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 179,
              "display_string" => "+179 Agility",
            },
          ],
          "spells" => [
            {
              "spell" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/spell/267177?namespace=static-8.2.5_31884-us",
                },
                "name" => "Tiny Elemental in a Jar",
                "id" => 267177,
              },
              "description" => "Equip: Your attacks and abilities have a chance to grant Phenomenal Power. On reaching 12 applications you will Unleash Lightning, inflicting 3,799 Nature damage.",
            },
          ],
          "sell_price" => {
            "value" => 446783,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "44",
              "silver" => "67",
              "copper" => "83",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "description" => "Phenomenal lightning power, itty bitty containment space.",
          "level" => {
            "value" => 325,
            "display_string" => "Item Level 325",
          },
          "is_subclass_hidden" => true,
          "name_description" => {
            "display_string" => "Heroic",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/160648?namespace=static-8.2.5_31884-us",
            },
            "id" => 160648,
          },
          "slot" => {
            "type" => "TRINKET_2",
            "name" => "Trinket 2",
          },
          "quantity" => 1,
          "context" => 3,
          "bonus_list" => [
            4798,
            1477,
            4786,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Frenetic Corpuscle",
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/160648?namespace=static-8.2.5_31884-us",
            },
            "id" => 160648,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/0?namespace=static-8.2.5_31884-us",
            },
            "name" => "Miscellaneous",
            "id" => 0,
          },
          "inventory_type" => {
            "type" => "TRINKET",
            "name" => "Trinket",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "unique_equipped" => "Unique-Equipped",
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 236,
              "display_string" => "+236 Agility",
            },
          ],
          "spells" => [
            {
              "spell" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/spell/278140?namespace=static-8.2.5_31884-us",
                },
                "name" => "Frenetic Corpuscle",
                "id" => 278140,
              },
              "description" => "Equip: Your attacks have a chance to grant you Frothing Rage for 45 sec. When Frothing Rage reaches 4 charges, your next attack will deal an additional 4,129 Physical damage. ",
            },
          ],
          "sell_price" => {
            "value" => 615224,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "61",
              "silver" => "52",
              "copper" => "24",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 355,
            "display_string" => "Item Level 355",
          },
          "is_subclass_hidden" => true,
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/159294?namespace=static-8.2.5_31884-us",
            },
            "id" => 159294,
          },
          "sockets" => [
            {
              "socket_type" => {
                "type" => "PRISMATIC",
                "name" => "Prismatic Socket",
              },
              "item" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/item/153711?namespace=static-8.2.5_31884-us",
                },
                "name" => "Quick Golden Beryl",
                "id" => 153711,
              },
              "display_string" => "+30 Haste",
              "media" => {
                "key" => {
                  "href" => "https://us.api.blizzard.com/data/wow/media/item/153711?namespace=static-8.2.5_31884-us",
                },
                "id" => 153711,
              },
            },
          ],
          "slot" => {
            "type" => "BACK",
            "name" => "Back",
          },
          "quantity" => 1,
          "context" => 23,
          "bonus_list" => [
            4779,
            4802,
            1512,
            4786,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Raal's Bib",
          "modified_appearance_id" => 97054,
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/159294?namespace=static-8.2.5_31884-us",
            },
            "id" => 159294,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4?namespace=static-8.2.5_31884-us",
            },
            "name" => "Armor",
            "id" => 4,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/4/item-subclass/1?namespace=static-8.2.5_31884-us",
            },
            "name" => "Cloth",
            "id" => 1,
          },
          "inventory_type" => {
            "type" => "CLOAK",
            "name" => "Back",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "armor" => {
            "value" => 69,
            "display_string" => "69 Armor",
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 121,
              "display_string" => "+121 Agility",
            },
            {
              "type" => {
                "type" => "INTELLECT",
                "name" => "Intellect",
              },
              "value" => 121,
              "display_string" => "+121 Intellect",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STRENGTH",
                "name" => "Strength",
              },
              "value" => 121,
              "display_string" => "+121 Strength",
              "is_negated" => true,
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 193,
              "display_string" => "+193 Stamina",
            },
            {
              "type" => {
                "type" => "CRIT_RATING",
                "name" => "Critical Strike",
              },
              "value" => 66,
              "display_string" => "+66 Critical Strike",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "HASTE_RATING",
                "name" => "Haste",
              },
              "value" => 46,
              "display_string" => "+46 Haste",
              "is_equip_bonus" => true,
            },
          ],
          "sell_price" => {
            "value" => 519762,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "51",
              "silver" => "97",
              "copper" => "62",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 340,
            "display_string" => "Item Level 340",
          },
          "transmog" => {
            "item" => {
              "key" => {
                "href" => "https://us.api.blizzard.com/data/wow/item/134111?namespace=static-8.2.5_31884-us",
              },
              "name" => "Hidden Cloak",
              "id" => 134111,
            },
            "display_string" => "Transmogrified to:\nHidden Cloak",
            "item_modified_appearance_id" => 77345,
          },
          "is_subclass_hidden" => true,
          "name_description" => {
            "display_string" => "Mythic",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
        {
          "item" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item/160678?namespace=static-8.2.5_31884-us",
            },
            "id" => 160678,
          },
          "slot" => {
            "type" => "MAIN_HAND",
            "name" => "Main Hand",
          },
          "quantity" => 1,
          "context" => 4,
          "bonus_list" => [
            4801,
            1462,
            4786,
          ],
          "quality" => {
            "type" => "EPIC",
            "name" => "Epic",
          },
          "name" => "Bow of Virulent Infection",
          "modified_appearance_id" => 99089,
          "media" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/media/item/160678?namespace=static-8.2.5_31884-us",
            },
            "id" => 160678,
          },
          "item_class" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/2?namespace=static-8.2.5_31884-us",
            },
            "name" => "Weapon",
            "id" => 2,
          },
          "item_subclass" => {
            "key" => {
              "href" => "https://us.api.blizzard.com/data/wow/item-class/2/item-subclass/2?namespace=static-8.2.5_31884-us",
            },
            "name" => "Bow",
            "id" => 2,
          },
          "inventory_type" => {
            "type" => "RANGED",
            "name" => "Ranged",
          },
          "binding" => {
            "type" => "ON_ACQUIRE",
            "name" => "Binds when picked up",
          },
          "weapon" => {
            "damage" => {
              "min_value" => 414,
              "max_value" => 561,
              "display_string" => "414 - 561 Damage",
              "damage_class" => {
                "type" => "PHYSICAL",
                "name" => "Physical",
              },
            },
            "attack_speed" => {
              "value" => 3000,
              "display_string" => "Speed 3.00",
            },
            "dps" => {
              "value" => 162.49998,
              "display_string" => "(162.5 damage per second)",
            },
          },
          "stats" => [
            {
              "type" => {
                "type" => "AGILITY",
                "name" => "Agility",
              },
              "value" => 216,
              "display_string" => "+216 Agility",
            },
            {
              "type" => {
                "type" => "STAMINA",
                "name" => "Stamina",
              },
              "value" => 344,
              "display_string" => "+344 Stamina",
            },
            {
              "type" => {
                "type" => "CRIT_RATING",
                "name" => "Critical Strike",
              },
              "value" => 129,
              "display_string" => "+129 Critical Strike",
              "is_equip_bonus" => true,
            },
            {
              "type" => {
                "type" => "MASTERY_RATING",
                "name" => "Mastery",
              },
              "value" => 71,
              "display_string" => "+71 Mastery",
              "is_equip_bonus" => true,
            },
          ],
          "sell_price" => {
            "value" => 1310419,
            "display_strings" => {
              "header" => "Sell Price:",
              "gold" => "131",
              "silver" => "4",
              "copper" => "19",
            },
          },
          "requirements" => {
            "level" => {
              "value" => 120,
              "display_string" => "Requires Level 120",
            },
          },
          "level" => {
            "value" => 340,
            "display_string" => "Item Level 340",
          },
          "durability" => {
            "value" => 120,
            "display_string" => "Durability 120 / 120",
          },
          "name_description" => {
            "display_string" => "Raid Finder",
            "color" => {
              "r" => 0,
              "g" => 255,
              "b" => 0,
              "a" => 1,
            },
          },
        },
      ],
    }
  end

  def profile_response_body
    {
      "_links" => {
        "self" => {
          "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut?namespace=profile-us",
        },
      },
      "id" => 129786456,
      "name" => "Dargonaut",
      "gender" => {
        "type" => "MALE",
        "name" => "Male",
      },
      "faction" => {
        "type" => "ALLIANCE",
        "name" => "Alliance",
      },
      "race" => {
        "key" => {
          "href" => "https://us.api.blizzard.com/data/wow/playable-race/4?namespace=static-8.2.5_31884-us",
        },
        "name" => "Night Elf",
        "id" => 4,
      },
      "character_class" => {
        "key" => {
          "href" => "https://us.api.blizzard.com/data/wow/playable-class/3?namespace=static-8.2.5_31884-us",
        },
        "name" => "Hunter",
        "id" => 3,
      },
      "active_spec" => {
        "key" => {
          "href" => "https://us.api.blizzard.com/data/wow/playable-specialization/253?namespace=static-8.2.5_31884-us",
        },
        "name" => "Beast Mastery",
        "id" => 253,
      },
      "realm" => {
        "key" => {
          "href" => "https://us.api.blizzard.com/data/wow/realm/94?namespace=dynamic-us",
        },
        "name" => "Shadowmoon",
        "id" => 94,
        "slug" => "shadowmoon",
      },
      "guild" => {
        "key" => {
          "href" => "https://us.api.blizzard.com/data/wow/guild/shadowmoon/the-gentlemens-club?namespace=profile-us",
        },
        "name" => "The Gentlemens Club",
        "id" => 40986523,
        "realm" => {
          "key" => {
            "href" => "https://us.api.blizzard.com/data/wow/realm/94?namespace=dynamic-us",
          },
          "name" => "Shadowmoon",
          "id" => 94,
          "slug" => "shadowmoon",
        },
      },
      "level" => 120,
      "experience" => 0,
      "achievement_points" => 7910,
      "achievements" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/achievements?namespace=profile-us",
      },
      "titles" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/titles?namespace=profile-us",
      },
      "pvp_summary" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/pvp-summary?namespace=profile-us",
      },
      "raid_progression" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/raid-progression?namespace=profile-us",
      },
      "media" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/character-media?namespace=profile-us",
      },
      "hunter_pets" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/hunter-pets?namespace=profile-us",
      },
      "last_login_timestamp" => 1575903852000,
      "average_item_level" => 348,
      "equipped_item_level" => 348,
      "specializations" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/specializations?namespace=profile-us",
      },
      "statistics" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/statistics?namespace=profile-us",
      },
      "mythic_keystone_profile" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/mythic-keystone-profile?namespace=profile-us",
      },
      "equipment" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/equipment?namespace=profile-us",
      },
      "appearance" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/appearance?namespace=profile-us",
      },
      "collections" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/collections?namespace=profile-us",
      },
      "active_title" => {
        "key" => {
          "href" => "https://us.api.blizzard.com/data/wow/title/114?namespace=static-8.2.5_31884-us",
        },
        "name" => "of Darnassus",
        "id" => 114,
        "display_string" => "{name} of Darnassus",
      },
      "reputations" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/reputations?namespace=profile-us",
      },
      "quests" => {
        "href" => "https://us.api.blizzard.com/profile/wow/character/shadowmoon/dargonaut/quests?namespace=profile-us",
      },
    }
  end

  # rubocop:enable Metrics/MethodLength, Style/NumericLiterals
end

# rubocop:enable Metrics/ModuleLength

RSpec.configure do |config|
  config.include ArmoryHelpers
end
