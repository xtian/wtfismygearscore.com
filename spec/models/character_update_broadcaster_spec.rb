# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CharacterUpdateBroadcaster do
  describe '.call' do
    let(:character) do
      instance_double(
        'Character',
        to_param: 1,
        class_name: '',
        median_difference: 0,
        name: ''
      ).as_null_object
    end

    it 'broadcasts to channel if caller is out of date' do
      allow(character).to receive(:updated_at) { Time.current }

      expect(ActionCable.server).to receive(:broadcast)
        .with('characters:1:armory_updates', hash_including(html: /<.+>/, id: 1))

      described_class.call(character, 1.hour.ago)
    end

    it 'does not broadcast if caller is up to date' do
      freeze_time do
        allow(character).to receive(:updated_at) { 1.hour.ago }

        expect(ActionCable.server).not_to receive(:broadcast)
        described_class.call(character, 1.hour.ago)
      end
    end
  end
end
