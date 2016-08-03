# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommentNotifier do
  describe '.call' do
    it 'triggers a Slack webhook notification' do
      comment = instance_double('Comment', poster_name: nil, poster_ip_address: '0.0.0.0', body: 'hi')
      character = instance_double('Character', region: 'us', realm: 'Shadowmoon', name: 'Dargonaut')

      slack_request = stub_request(:post, Rails.application.secrets.slack_webhook_url)

      described_class.call(comment, character)

      expect(slack_request).to have_been_requested
    end
  end
end
