# frozen_string_literal: true
require 'rails_helper'

RSpec.describe RecentCommentPresenter do
  let(:recent_comment) do
    instance_double(
      'RecentComment',
      character_class: 5,
      character_name: 'Granwe',
      character_realm: 'Shadowmoon',
      character_region: 0
    )
  end

  subject { described_class.new(recent_comment) }

  describe '#character_info' do
    it 'returns array of identifying info' do
      expect(subject.character_info).to eq(%w(us Shadowmoon Granwe))
    end
  end

  describe '#character_link_class' do
    it 'returns correct CSS class for character class name' do
      expect(subject.character_link_class).to eq('CharacterLink--deathKnight')
    end
  end
end
