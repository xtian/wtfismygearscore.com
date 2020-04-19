# frozen_string_literal: true

require "rails_helper"
require "akismet"

RSpec.describe Akismet do
  subject { described_class.new(is_test: true, key: "foo", url: "bar") }

  let(:url) { "https://foo.rest.akismet.com" }
  let(:comment) do
    instance_double(
      "Comment",
      body: "body",
      created_at: Time.current,
      poster_name: "poster-name",
      poster_ip_address: IPAddr.new("0.0.0.0"),
      referrer: "r",
      user_agent: "ua",
    )
  end

  let(:params) do
    {
      blog: "bar",
      comment_author: "poster-name",
      comment_content: "body",
      comment_date_gmt: /.+Z/,
      is_test: "true",
      referrer: "r",
      user_agent: "ua",
      user_ip: "0.0.0.0",
    }
  end

  describe "#new" do
    it "raises an argument error if key is not provided" do
      expect { described_class.new(is_test: "", key: nil, url: "") }.to raise_error(ArgumentError, "Akismet key and url required")
    end

    it "raises an argument error if url is not provided" do
      expect { described_class.new(is_test: "", key: "", url: nil) }.to raise_error(ArgumentError, "Akismet key and url required")
    end
  end

  describe "#spam?" do
    it "returns true if Akismet considers the comment spam" do
      stub_request(:post, "#{url}/1.1/comment-check")
        .with(body: params)
        .to_return(body: "true")

      expect(subject.spam?(comment)).to eq(true)
    end

    it "returns false if Akismet considers the comment valid" do
      stub_request(:post, "#{url}/1.1/comment-check").to_return(body: "false")
      expect(subject.spam?(comment)).to eq(false)
    end

    it "handles errors" do
      stub_request(:post, "#{url}/1.1/comment-check")
        .to_return(headers: { "X-akismet-debug-help" => "foo" })

      expect {
        subject.spam?(comment)
      }.to raise_error("foo")
    end
  end

  describe "#spam!" do
    it "submits comment as spam" do
      spam_submission = stub_request(:post, "#{url}/1.1/submit-spam").with(body: params)

      subject.spam!(comment)

      expect(spam_submission).to have_been_requested
    end

    it "handles errors" do
      stub_request(:post, "#{url}/1.1/submit-spam")
        .to_return(headers: { "X-akismet-debug-help" => "foo" })

      expect {
        subject.spam!(comment)
      }.to raise_error("foo")
    end
  end
end
