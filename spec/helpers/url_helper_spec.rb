# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlHelper do
  describe '#character_path' do
    it 'handles a character model' do
      character = instance_double(
        'Character',
        region: 'us',
        realm: 'shadowmoon',
        name: 'dewbaca'
      )

      expect(helper.character_path(character, page: 2)).to eq('/us/shadowmoon/dewbaca?page=2')
    end

    it 'handles region, realm, and name as params' do
      expect(helper.character_path('us', 'shadowmoon', 'dargonaut')).to eq('/us/shadowmoon/dargonaut')
    end
  end

  describe '#comments_path' do
    it 'handles a character model' do
      character = instance_double(
        'Character',
        region: 'us',
        realm: 'shadowmoon',
        name: 'dewbaca'
      )

      expect(helper.comments_path(character)).to eq('/us/shadowmoon/dewbaca/comments')
    end

    it 'handles region, realm, and name as params' do
      expect(helper.comments_path('us', 'shadowmoon', 'dargonaut')).to eq('/us/shadowmoon/dargonaut/comments')
    end
  end
end
