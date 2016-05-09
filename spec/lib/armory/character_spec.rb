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
end
