# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LegacyController do
  describe '#index' do
    it 'handles legacy URLs with `d=region`' do
      get :index, params: { d: 'us', r: 'shadowmoon' }
      expect(subject).to redirect_to(characters_url('us', 'shadowmoon'))
    end

    it 'handles legacy URLs with `r=region`' do
      get :index, params: { r: 'eu' }
      expect(subject).to redirect_to(characters_url('eu'))
    end

    it 'handles legacy URLS with no params' do
      get :index
      expect(subject).to redirect_to(characters_url('world'))
    end
  end

  describe '#show' do
    it 'handles legacy URLs with `d=region`' do
      get :show, params: { d: 'us', r: 'shadowmoon', n: 'dargonaut' }
      expect(subject).to redirect_to(character_url('us', 'shadowmoon', 'dargonaut'))
    end

    it 'handles legacy URLs with `r=region`' do
      get :show, params: { r: 'eu', s: 'shadowmoon', n: 'dargonaut' }
      expect(subject).to redirect_to(character_url('eu', 'shadowmoon', 'dargonaut'))
    end

    it 'handles legacy URLS with insufficient params' do
      expect {
        get :show, params: { r: 'eu', s: 'shadowmoon' }
      }.to raise_error(ActionController::RoutingError)
    end
  end
end
