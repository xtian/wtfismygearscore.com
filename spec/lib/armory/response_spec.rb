# frozen_string_literal: true
require 'spec_helper'
require 'armory/character'

RSpec.describe Armory::Response do
  def faraday_response(status, body)
    instance_double('Faraday::Response', status: status, body: body)
  end

  describe '#body' do
    it 'returns parsed JSON' do
      subject = described_class.new(faraday_response(200, '{}'))
      expect(subject.body).to eq({})
    end

    it 'handles an empty body' do
      subject = described_class.new(faraday_response(504, ''))
      expect(subject.body).to eq({})
    end
  end

  describe '#error_message' do
    it 'returns string with error code and detail' do
      subject = described_class.new(faraday_response(403, '{"code":"403", "detail": "Account Inactive"}'))
      expect(subject.error_message).to eq('403 Account Inactive')
    end

    it 'returns status code if error code is not available' do
      subject = described_class.new(faraday_response(504, ''))
      expect(subject.error_message).to eq('504')
    end
  end

  describe '#status' do
    it 'returns 404 for successful responses with an empty body' do
      subject = described_class.new(faraday_response(200, '{}'))
      expect(subject.status).to eq(404)
    end

    it 'returns status of the original response' do
      subject = described_class.new(faraday_response(504, ''))
      expect(subject.status).to eq(504)
    end
  end
end
