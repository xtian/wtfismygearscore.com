# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#page_title' do
    it 'joins page title and site name' do
      title = helper.page_title(
        page_title: 'page title',
        site_name: 'site name',
        subtitle: 'subtitle'
      )

      expect(title).to eq('page title — site name')
    end

    it 'includes subtitle if no page title is given' do
      title = helper.page_title(
        page_title: nil,
        site_name: 'site name',
        subtitle: 'subtitle'
      )

      expect(title).to eq('site name — subtitle')
    end
  end
end
