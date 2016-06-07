# frozen_string_literal: true
module UrlHelper
  def character_path(*args)
    return super.downcase if args.length == 3

    character = args.first
    super(character.region, character.realm, character.name).downcase
  end

  def characters_path(*)
    super.downcase
  end

  def comments_path(*args)
    return super if args.length == 3
    "#{character_path(args.first)}/comments"
  end
end
