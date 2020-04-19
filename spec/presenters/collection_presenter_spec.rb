# frozen_string_literal: true

require "rails_helper"

RSpec.describe CollectionPresenter do
  let(:test_class) do
    Class.new do
      def initialize(object); end

      def foo
        "foo"
      end
    end
  end

  describe ".new" do
    it "returns an object that proxies to the collection" do
      relation = instance_double("ActiveRecord::Relation")
      expect(relation).to receive(:where)

      described_class.new(relation, test_class).where
    end

    it "returns an enumerable that wraps each item in a presenter" do
      presented = described_class.new([double, double], test_class)

      expect(presented.map(&:foo)).to eq(%w[foo foo])
    end

    it "returns an enumerable that wraps calls to #to_ary" do
      relation = instance_double("ActiveRecord::Relation", to_ary: [double, double])
      presented = described_class.new(relation, test_class)

      expect(presented.to_ary.map(&:foo)).to eq(%w[foo foo])
    end
  end
end
