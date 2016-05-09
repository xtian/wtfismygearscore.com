class Armory
  class Character
    attr_reader :region

    def initialize(region, response_body)
      @region = region.upcase
      @body = response_body
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

    private

    attr_reader :body

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
  end
end
