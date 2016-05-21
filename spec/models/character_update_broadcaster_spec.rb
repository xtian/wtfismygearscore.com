require 'rails_helper'

RSpec.describe CharacterUpdateBroadcaster do
  describe '.call' do
    it 'broadcasts to channel if caller is out of date' do
      character = instance_double('Character', to_param: 1, updated_at: Time.current, name: '').as_null_object

      expect(ActionCable.server).to receive(:broadcast).with("characters:1:armory_updates", hash_including(:character))

      described_class.call(character, 1.hour.ago)
    end

    it 'does not broadcast if caller is up to date' do
      character = instance_double('Character', to_param: 1, updated_at: 1.hour.ago)

      expect(ActionCable.server).not_to receive(:broadcast)

      described_class.call(character, 1.hour.ago)
    end
  end
end
