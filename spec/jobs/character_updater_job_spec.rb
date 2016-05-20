require 'rails_helper'

RSpec.describe CharacterUpdaterJob do
  describe '#perform' do
    it 'calls character updater' do
      character = Fabricate(:character)
      expect(CharacterUpdater).to receive(:call).with(character)

      subject.perform(character)
    end
  end
end
