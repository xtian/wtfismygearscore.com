# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def index
      render html: 'foo'
    end
  end

  it 'assigns UUID cookie' do
    get :index

    expect(cookies.signed[:uuid]).to be_present
  end
end
