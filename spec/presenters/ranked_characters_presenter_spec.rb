# frozen_string_literal: true
require 'rails_helper'

RSpec.describe RankedCharactersPresenter do
  let(:characters) do
    [
      instance_double('Character', id: 1),
      instance_double('Character', id: 2)
    ]
  end

  let(:query) { instance_double('RankingQuery', per_page: 1, realm: nil) }

  subject { described_class.new([], query) }

  describe '#extra_column_name' do
    it 'returns Guild for realm ranking' do
      allow(query).to receive(:realm) { 'Shadowmoon' }

      expect(subject.extra_column_name).to eq('Guild')
    end

    it 'returns Realm for region ranking' do
      expect(subject.extra_column_name).to eq('Realm')
    end
  end

  describe '#first_page?' do
    # rubocop:disable RSpec/VerifiedDoubles
    it 'returns true if first character is ranked 1' do
      character = double(rank: 1)
      subject = described_class.new([character], query)

      expect(subject.first_page?).to eq(true)
    end
    # rubocop:enable RSpec/VerifiedDoubles

    it 'handles an empty collection' do
      expect(subject.first_page?).to eq(true)
    end
  end

  describe '#last_page?' do
    it 'returns true if the ranking contains fewer characters than the per page value' do
      expect(subject.last_page?).to eq(true)
    end

    it 'returns false if the ranking contains the same number of characters as the per page value' do
      subject = described_class.new([instance_double('Character')], query)

      expect(subject.last_page?).to eq(false)
    end
  end

  describe '#prev_cursor' do
    it 'returns ID of first character' do
      subject = described_class.new(characters, query)

      expect(subject.prev_cursor).to eq(1)
    end
  end

  describe '#next_cursor' do
    it 'returns ID of last character' do
      subject = described_class.new(characters, query)

      expect(subject.next_cursor).to eq(2)
    end
  end
end
