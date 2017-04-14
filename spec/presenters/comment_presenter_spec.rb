# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPresenter do
  subject { described_class.new(comment) }

  let(:comment) { instance_double('Comment', poster_name: nil) }

  describe '#poster_name' do
    it 'defaults to Anonymous' do
      expect(subject.poster_name).to eq('Anonymous')
    end

    it 'delegates to comment' do
      allow(comment).to receive(:poster_name) { 'idealposter' }
      expect(subject.poster_name).to eq('idealposter')
    end
  end

  describe '#timestamp' do
    it 'returns iso8601 string' do
      allow(comment).to receive(:created_at) { 1.week.ago }
      expect(subject.timestamp).to eq(1.week.ago.iso8601)
    end
  end

  describe '#posted_at' do
    it 'returns human readable date string' do
      allow(comment).to receive(:created_at) { Time.new(2016, 5, 29).utc }
      expect(subject.posted_at).to eq('May 29, 2016')
    end

    it 'returns relative time for recent dates' do
      allow(comment).to receive(:created_at) { 23.hours.ago }
      expect(subject.posted_at).to eq('about 23 hours ago')
    end
  end
end
