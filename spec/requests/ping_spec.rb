# typed: false
# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'Ping endpoint' do
  describe 'GET /ping.txt' do
    it 'returns 200' do
      get '/ping.txt'
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('ok')
    end
  end
end
# rubocop:enable RSpec/DescribeClass
