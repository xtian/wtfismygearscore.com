# frozen_string_literal: true

require "rails_helper"

class TestController < ApplicationController; end

RSpec.describe ApplicationController do
  controller TestController do
    def index
      render html: "foo"
    end

    def authenticity
      raise ActionController::InvalidAuthenticityToken
    end

    def mime_type
      raise Mime::Type::InvalidMimeType
    end
  end


  it "assigns UUID cookie" do
    get :index

    expect(cookies.signed[:uuid]).to be_present
  end

  it "handles authenticity token exceptions" do
    routes.draw { post :authenticity, to: "test#authenticity" }

    post :authenticity
    expect(response.status).to eq(400)
  end

  it "handles invalid MIME type exceptions" do
    routes.draw { post :mime_type, to: "test#mime_type" }

    post :mime_type
    expect(response.status).to eq(400)
  end
end
