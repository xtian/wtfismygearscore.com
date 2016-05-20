require 'rails_helper'

RSpec.describe CharacterUpdaterJob do
  describe '#perform' do
    it 'calls character updater and broadcaster' do
      character = instance_double('Character', updated_at: Time.current)
      expect(CharacterUpdater).to receive(:call).with(character).and_return(character)
      expect(CharacterUpdateBroadcaster).to receive(:call).with(character, character.updated_at)

      subject.perform(character)
    end
  end
end
