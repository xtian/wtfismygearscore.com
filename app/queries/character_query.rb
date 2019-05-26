# frozen_string_literal: true

class CharacterQuery
  attr_reader :comments

  # @option options [String] name
  # @option options [Integer] page
  # @option options [Integer] per_page
  # @option options [String] realm
  # @option options [String] region
  def initialize(options)
    options.each { |key, value| instance_variable_set("@#{key}", value) }
  end

  # Convenience method to avoid object initialization
  # @param options [Hash]
  # @return [CharacterPresenter]
  def self.call(options = {})
    new(options).call
  end

  # Fetches {Character} and appropriate page of {Comment}s from the DB. If
  # character is not cached, it will be requested from the Armory. If it is
  # cached, a background job to check for updates will be enqueued.
  # @return [CharacterPresenter]
  def call
    @character = fetch_character
    @comments = fetch_comments

    CharacterPresenter.new(character, self)
  end

  # @return [String] canonical URL to disambiguate duplicate content for SEO
  def canonical_url
    Rails.application.routes.url_helpers.url_for(
      page_params.merge(
        action: 'show',
        controller: 'characters',
        host: Rails.application.secrets.base_url
      )
    ).downcase
  end

  # @return [Boolean] whether current comments page is the first one available
  def first_page?
    offset.eql?(0)
  end

  # @return [Boolean] whether current comments page is the last one available
  def last_page?
    (offset + per_page) >= character.comments_count
  end

  private

  attr_reader :character, :page, :per_page

  def fetch_character
    character = Character.from_params(params)

    # Initiate synchronous Blizzard API call if character is not cached in DB
    return CharacterUpdater.call(character) if character.new_record?

    # Update character from Armory in background
    CharacterUpdaterJob.perform_later(character)
    character
  end

  def fetch_comments
    character.comments
      .select(:body, :created_at, :poster_name, :poster_ip_address)
      .limit(per_page)
      .offset(offset)
      .order(created_at: :desc)
  end

  def offset
    (page - 1) * per_page
  end

  def page_params
    {
      name: character.name,
      page: page,
      per_page: per_page,
      realm: character.realm,
      region: character.region
    }
  end

  def params
    { region: @region, realm: @realm.strip, name: @name.strip }
  end
end
