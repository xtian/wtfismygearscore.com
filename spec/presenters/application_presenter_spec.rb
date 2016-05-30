require 'spec_helper'

require_relative '../../app/presenters/application_presenter'

RSpec.describe ApplicationPresenter do
  class TestPresenter < described_class
    def foo
      'foo'
    end
  end

  describe '.present_collection' do
    it 'returns an object that proxies to the collection' do
      relation = instance_double('ActiveRecord::Relation')
      expect(relation).to receive(:where)

      described_class.present_collection(relation).where
    end

    it 'returns an enumerable that wraps each item in a presenter' do
      presented = TestPresenter.present_collection([double, double])

      expect(presented.map(&:foo)).to eq(%w(foo foo))
    end

    it 'returns an enumerable that wraps calls to #to_ary' do
      relation = instance_double('ActiveRecord::Relation', to_ary: [double, double])
      presented = TestPresenter.present_collection(relation)

      expect(presented.to_ary.map(&:foo)).to eq(%w(foo foo))
    end
  end
end
