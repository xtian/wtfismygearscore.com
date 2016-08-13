# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommentsController do
  describe '#create' do
    let(:character_info) { { region: 'us', realm: 'shadowmoon', name: 'dargonaut' } }

    it 'handles invalid character info' do
      expect {
        post :create, params: character_info
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns an error flash message if comment is invalid' do
      fabricate_character(character_info)

      post :create, params: character_info.merge(comment: { body: nil })

      expect(flash[:alert]).to eq([I18n.t('activerecord.errors.models.comment.attributes.body.blank')])
    end
  end
end
