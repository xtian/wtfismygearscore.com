class Armory
  class Character
    attr_reader :average_ilvl, :region

    def initialize(region, response_body)
      @region = region.upcase
      @body = response_body
      process_items
    end

    %w(name realm level).each do |method_name|
      define_method method_name do
        body[method_name]
      end
    end

    def class_name
      CLASSES[body["class"] - 1]
    end

    def guild_name
      body["guild"]["name"]
    end

    def items
      body["items"]
    end

    def maximum_ilvl
      @_max_ilvl ||= ilvls.max
    end

    def minimum_ilvl
      @_min_ilvl ||= ilvls.min
    end

    private

    attr_reader :body, :ilvls

    CLASSES = [
      "Warrior",
      "Paladin",
      "Hunter",
      "Rogue",
      "Priest",
      "Death Knight",
      "Shaman",
      "Mage",
      "Warlock",
      "Monk",
      "Druid"
    ].freeze

    def process_items
      body["items"].delete "averageItemLevelEquipped"
      @average_ilvl = body["items"].delete("averageItemLevel")

      @ilvls = body["items"]
        .reject { |k| %w(shirt tabard).include? k }
        .map { |_k, hash| hash["itemLevel"] }
    end
  end
end
