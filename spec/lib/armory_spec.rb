# frozen_string_literal: true

require "spec_helper"
require "armory"
require "support/armory_helpers"

RSpec.describe Armory do
  subject { described_class.new(client_id: client_id, client_secret: client_secret, timeout: 15) }

  let(:client_id) { "foo" }
  let(:client_secret) { "bar" }

  describe "#fetch_character" do
    def stub_armory_request(status: 200, body: "")
      stub_request(:get, %r{https://.+\.api\.blizzard\.com/.+})
        .to_return(status: status, body: body)
    end

    before do
      stub_character_request(client_id: client_id, client_secret: client_secret)
    end

    let(:args) do
      { region: "us", realm: "Shadowmoon", name: "Dargonaut" }
    end

    it "fetches a character from the armory" do
      character = subject.fetch_character(**args)
      expect(character.name).to eq("Dargonaut")
    end

    it "handles utf-8 URLs" do
      stub_character_request(name: "N%C3%A5jd", client_id: client_id, client_secret: client_secret)

      expect {
        subject.fetch_character(region: "us", realm: "shadowmoon", name: "Nåjd")
      }.not_to output.to_stderr
    end

    it "raises a ServerError for 500s" do
      stub_armory_request(status: 500)

      expect { subject.fetch_character(**args) }.to raise_error(Armory::ServerError, %r{https://.+})
    end

    it "raises a ServerError for 503s" do
      stub_armory_request(status: 503)

      expect { subject.fetch_character(**args) }.to raise_error(Armory::ServerError, %r{https://.+})
    end

    it "raises a ServerError for 504s" do
      stub_armory_request(status: 504)

      expect { subject.fetch_character(**args) }.to raise_error(Armory::ServerError, %r{https://.+})
    end

    it "raises a ServerError for invalid response bodies" do
      stub_armory_request(body: "<DOCTYPE html>")

      expect { subject.fetch_character(**args) }.to raise_error(Armory::ServerError, %r{https://.+})
    end

    it "raises a ServerError for timeouts" do
      stub_request(:get, %r{https://.+\.api\.blizzard\.com/.+}).to_timeout

      expect { subject.fetch_character(**args) }.to raise_error(Armory::ServerError, %r{https://.+})
    end

    it "raises a NotUpdatedError for 403s" do
      stub_armory_request(status: 403, body: "{}")

      expect { subject.fetch_character(**args) }.to raise_error(Armory::NotUpdatedError, %r{https://.+})
    end

    it "raises a NotFoundError for 404s" do
      stub_armory_request(status: 404, body: "{}")

      expect { subject.fetch_character(**args) }.to raise_error(Armory::NotFoundError, %r{https://.+})
    end
  end
end
