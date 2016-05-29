module UrlHelper
  def character_path(*args)
    return super if args.length == 3

    character = args.first
    super(character.region, character.realm, character.name)
  end
end
