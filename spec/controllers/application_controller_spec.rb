# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def index
      render html: 'foo'
    end

    def create
      raise ActionController::InvalidAuthenticityToken
    end
  end

  it 'assigns UUID cookie' do
    get :index

    expect(cookies.signed[:uuid]).to be_present
  end

  it 'handles authenticity token exceptions' do
    post :create
    expect(response.status).to eq(400)
  end
end
