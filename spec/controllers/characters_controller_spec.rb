# frozen_string_literal: true
require 'rails_helper'
require 'support/armory_helpers'

RSpec.describe CharactersController do
  let(:character_info) { { region: 'us', realm: 'shadowmoon', name: 'dargonaut' } }
  let!(:character_request) { stub_character_request }

  describe '#show' do
    context 'with an existing character' do
      let!(:character) { Fabricate(:character, character_info) }

      it 'loads the character from the DB' do
        get :show, params: character_info
        expect(character_request).not_to have_been_requested
      end

      it 'starts a job to refresh the character' do
        expect {
          get :show, params: character_info
        }.to have_enqueued_job(CharacterUpdaterJob).with(character)
      end
    end

    it 'loads newly requested characters from the Armory' do
      get :show, params: character_info
      expect(character_request).to have_been_requested
    end

    it 'stores newly requested characters in the DB' do
      expect(Character.count).to eq(0)

      get :show, params: character_info

      expect(Character.count).to eq(1)
    end

    it 'handles a 504 response from the Armory' do
      stub_request(:get, %r{https://.+\.api\.battle\.net/.+})
        .to_return(status: 504, body: '')

      get :show, params: character_info

      expect(response.status).to eq(504)
    end

    it 'handles a 500 response from the Armory' do
      stub_request(:get, %r{https://.+\.api\.battle\.net/.+})
        .to_return(status: 500, body: '')

      get :show, params: character_info

      expect(response.status).to eq(502)
    end
  end
end
