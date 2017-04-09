# frozen_string_literal: true

# Sends notifications for new comments to Slack webhook
class CommentNotifier
  # @param comment [Comment]
  # @param character [Character]
  def initialize(comment, character)
    @comment = comment
    @character = character
  end

  # Convenience method to avoid object initialization
  # @param comment [Comment]
  # @param character [Character]
  # @return [void]
  def self.call(comment, character)
    new(comment, character).call
  end

  # @return [void]
  def call
    return if webhook_url.blank?
    Slack::Notifier.new(webhook_url).ping '', attachments: [message_options]
  end

  private

  attr_reader :comment, :character

  def message_options
    {
      text: "New comment posted on [#{character.name}](#{page_url}):",
      fields: [
        { title: 'Poster Name', value: comment.poster_name, short: true },
        { title: 'Poster IP Address', value: comment.poster_ip_address.to_s, short: true },
        { title: 'Body', value: comment.body }
      ]
    }
  end

  def page_url
    Rails.application.routes.url_helpers.character_url(
      character.region,
      character.realm,
      character.name
    )
  end

  def webhook_url
    Rails.application.secrets.slack_webhook_url
  end
end
