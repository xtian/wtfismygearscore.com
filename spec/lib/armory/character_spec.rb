require 'spec_helper'
require 'armory/character'
require 'support/armory_helpers'

RSpec.describe Armory::Character do
  let(:body) do
    character_response_body
  end

  subject { described_class.new('us', body) }

  describe '#name' do
    it 'returns character name' do
      expect(subject.name).to eq('Dargonaut')
    end
  end

  describe '#realm' do
    it 'returns character realm' do
      expect(subject.realm).to eq('Shadowmoon')
    end
  end

  describe '#region' do
    it 'returns character region' do
      expect(subject.region).to eq('US')
    end
  end

  describe '#level' do
    it 'returns character level' do
      expect(subject.level).to eq(100)
    end
  end

  describe '#class_name' do
    it 'returns character class' do
      expect(subject.class_name).to eq('Hunter')
    end
  end

  describe '#average_ilvl' do
    it 'returns the character’s average item level' do
      expect(subject.average_ilvl).to eq(681)
    end
  end

  describe '#maximum_ilvl' do
    it 'returns the character’s highest item level' do
      expect(subject.maximum_ilvl).to eq(695)
    end
  end

  describe '#minimum_ilvl' do
    it 'returns the character’s lowest item level' do
      expect(subject.minimum_ilvl).to eq(655)
    end
  end

  describe '#items' do
    it 'returns hash of items' do
      keys = subject.items.keys

      expect(keys).to include("head")
      expect(keys).to include("chest")
      expect(keys).not_to include("averageItemLevel")
      expect(keys).not_to include("averageItemLevelEquipped")
    end
  end
end
