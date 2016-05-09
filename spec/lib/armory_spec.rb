require 'spec_helper'
require 'armory'
require 'support/armory_helpers'

RSpec.describe Armory do
  subject { described_class.new('not-a-bnet-key') }

  describe '#fetch_character' do
    before do
      stub_character_request
    end

    it 'fetches a character from the armory' do
      character = subject.fetch_character('us', 'Shadowmoon', 'Dargonaut')
      expect(character.name).to eq('Dargonaut')
    end

    it 'raises an error for failed requests' do
      stub_request(:get, %r{https://.+\.api\.battle\.net/.+})
        .to_return(status: 403, body: '{"code":"403", "detail": "Account Inactive"}')

      expect {
        subject.fetch_character('us', 'Shadowmoon', 'Dargonaut')
      }.to raise_error
    end
  end
end
