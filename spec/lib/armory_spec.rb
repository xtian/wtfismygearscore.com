# frozen_string_literal: true
require 'spec_helper'
require 'armory'
require 'support/armory_helpers'

RSpec.describe Armory do
  subject { described_class.new('not-a-bnet-key') }

  describe '#fetch_character' do
    before do
      stub_character_request
    end

    let(:args) do
      { region: 'us', realm: 'Shadowmoon', name: 'Dargonaut' }
    end

    it 'fetches a character from the armory' do
      character = subject.fetch_character(args)
      expect(character.name).to eq('Dargonaut')
    end

    it 'raises an error for failed requests' do
      stub_request(:get, %r{https://.+\.api\.battle\.net/.+})
        .to_return(status: 403, body: '{"code":"403", "detail": "Account Inactive"}')

      expect { subject.fetch_character(args) }.to raise_error(/403 Account Inactive/)
    end

    it 'raises a NotFoundError for 404s' do
      stub_request(:get, %r{https://.+\.api\.battle\.net/.+})
        .to_return(status: 404, body: '{"code":"nok", "detail": "Character not found."}')

      expect { subject.fetch_character(args) }.to raise_error(Armory::NotFoundError)
    end
  end
end
