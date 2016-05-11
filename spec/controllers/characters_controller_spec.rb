require 'rails_helper'
require 'support/armory_helpers'

RSpec.describe CharactersController do
  before do
    stub_character_request
  end

  describe '#show' do
    it 'stores newly requested characters in the database' do
      expect(Character.count).to eq(0)

      get :show, params: { region: 'us', realm: 'shadowmoon', name: 'dargonaut' }

      expect(Character.count).to eq(1)
    end

    it 'updates existing characters in the database' do
      character = Fabricate(
        :character,
        region: 'us',
        realm: 'shadowmoon',
        name: 'dargonaut',
        score: 1,
        level: 1
      )

      get :show, params: { region: 'us', realm: 'shadowmoon', name: 'dargonaut' }

      expect(character.reload.score).to eq(19_717)
      expect(character.level).to eq(100)
    end
  end
end
