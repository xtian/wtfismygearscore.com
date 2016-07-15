# frozen_string_literal: true
require 'rails_helper'

RSpec.describe RecentComment do
  describe '.refresh' do
    it 'calls Scenic refresh method' do
      expect(Scenic.database).to receive(:refresh_materialized_view).with('recent_comments', concurrently: true)

      described_class.refresh
    end
  end

  describe '#save' do
    it 'raises exception' do
      expect { subject.save }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
  end
end
