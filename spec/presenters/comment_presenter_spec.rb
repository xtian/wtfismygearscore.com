# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommentPresenter do
  let(:comment) { instance_double('Comment', poster_name: nil) }
  subject { described_class.new(comment) }

  describe '#poster_name' do
    it 'defaults to Anonymous' do
      expect(subject.poster_name).to eq('Anonymous')
    end

    it 'delegates to comment' do
      allow(comment).to receive(:poster_name).and_return('idealposter')
      expect(subject.poster_name).to eq('idealposter')
    end
  end

  describe '#timestamp' do
    it 'returns iso8601 string' do
      allow(comment).to receive(:created_at).and_return(1.week.ago)
      expect(subject.timestamp).to eq(1.week.ago.iso8601)
    end
  end

  describe '#posted_at' do
    it 'returns human readable date string' do
      allow(comment).to receive(:created_at).and_return(Date.new(2016, 05, 29))
      expect(subject.posted_at).to eq('May 29, 2016')
    end
  end
end
