module UrlHelper
  def character_path(*args)
    return super if args.length == 3

    character = args.first
    super(character.region, character.realm, character.name)
  end

  def comments_path(*args)
    return super if args.length == 3
    "#{character_path(args.first)}/comments"
  end
end
