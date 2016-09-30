# frozen_string_literal: true
require 'rails_helper'
require 'akismet'

RSpec.describe Akismet do
  subject { described_class.new(is_test: true, key: 'foo', url: 'bar') }

  let(:comment) do
    instance_double(
      'Comment',
      body: 'body',
      created_at: Time.current,
      poster_name: 'poster-name',
      poster_ip_address: IPAddr.new('0.0.0.0'),
      referrer: 'r',
      user_agent: 'ua'
    )
  end

  describe '#new' do
    it 'raises an argument error if key is not provided' do
      expect { described_class.new(is_test: '', key: nil, url: '') }
        .to raise_error(ArgumentError, 'Akismet key and url required')
    end

    it 'raises an argument error if url is not provided' do
      expect { described_class.new(is_test: '', key: '', url: nil) }
        .to raise_error(ArgumentError, 'Akismet key and url required')
    end
  end

  describe '#spam?' do
    it 'returns true if Akismet considers the comment spam' do
      url = %r{
        https://foo\.rest\.akismet\.com/.+/comment-check
        \?blog=bar&comment_author=poster-name&comment_content=body&comment_date_gmt=.+Z
        &is_test=true&referrer=r&user_agent=ua&user_ip=0.0.0.0
      }x

      stub_request(:get, url).to_return(body: 'true')

      expect(subject.spam?(comment)).to eq(true)
    end

    it 'returns false if Akismet considers the comment valid' do
      stub_request(:get, %r{https://.+\.akismet\.com/.+/comment-check})

      expect(subject.spam?(comment)).to eq(false)
    end

    it 'handles errors' do
      stub_request(:get, %r{https://.+\.akismet\.com/.+/comment-check})
        .to_return(body: 'invalid', headers: { 'X-akismet-debug-help' => 'foo' })

      expect {
        subject.spam?(comment)
      }.to raise_error('foo')
    end
  end

  describe '#spam!' do
    it 'submits comment as spam' do
      url = %r{
        https://foo\.rest\.akismet\.com/.+/submit-spam
        \?blog=bar&comment_author=poster-name&comment_content=body&comment_date_gmt=.+Z
        &is_test=true&referrer=r&user_agent=ua&user_ip=0.0.0.0
      }x

      spam_submission = stub_request(:get, url)

      subject.spam!(comment)

      expect(spam_submission).to have_been_requested
    end
  end
end
