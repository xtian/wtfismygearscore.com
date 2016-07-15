# frozen_string_literal: true
module UrlHelper
  # @overload character_path(character)
  #   @param character [Character]
  # @overload character_path(region, realm, name)
  #   @param region [String]
  #   @param realm [String]
  #   @param name [String]
  # @return [String] path to character page
  def character_path(*args)
    return super if args.length == 3

    character = args.first
    super(character.region, character.realm, character.name)
  end

  # @overload comments_path(character)
  #   @param character [Character]
  # @overload comments_path(region, realm, name)
  #   @param region [String]
  #   @param realm [String]
  #   @param name [String]
  # @return [String] path to comments route
  def comments_path(*args)
    return super if args.length == 3
    "#{character_path(args.first)}/comments"
  end
end
