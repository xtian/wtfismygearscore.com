# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Character do
  subject { Fabricate.build(:character) }

  it { should define_enum_for(:class_name).with(CLASSES) }
  it { should define_enum_for(:faction).with(FACTIONS) }
  it { should define_enum_for(:region).with(VALID_REGIONS_WITH_REALM) }

  %i(avg_ilvl class_name level max_ilvl min_ilvl name realm region score).each do |field|
    it { should validate_presence_of(field) }
  end

  %i(avg_ilvl level max_ilvl min_ilvl score).each do |field|
    it { should validate_numericality_of(field).only_integer.is_greater_than(0) }
  end

  it { should have_db_index([:name, :realm, :region]).unique }
  it { should have_db_index([:score, :region, :realm, :name]) }

  describe '#create_comment' do
    it 'creates a comment' do
      subject.save!

      subject.create_comment(
        poster_name: 'IdealPoster',
        poster_ip_address: '127.0.0.1',
        body: 'hi'
      )

      comment = subject.comments.first
      expect(comment.body).to eq('hi')
      expect(comment.poster_name).to eq('IdealPoster')
    end
  end

  describe '#destroy!' do
    it 'deletes all associated comments' do
      subject.save!
      comment = Fabricate(:comment, character: subject)

      subject.destroy!

      expect { comment.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#median_difference' do
    it 'returns difference between character score and median score for level' do
      (1..3).each do |i|
        median = instance_double('MedianGearscore', median_score: i)
        allow(MedianGearscore).to receive(:find_or_initialize_by).with(level: i) { median }
      end

      subject = Fabricate.build(:character, level: 1, score: 2)
      expect(subject.median_difference).to eq(1)

      subject = Fabricate.build(:character, level: 2, score: 2)
      expect(subject.median_difference).to eq(0)

      subject = Fabricate.build(:character, level: 3, score: 2)
      expect(subject.median_difference).to eq(-1)
    end
  end

  describe '#update_from_armory' do
    let(:character) do
      instance_double(
        'Armory::Character',
        avg_ilvl: subject.avg_ilvl + 1,
        class_name: (CLASSES - [subject.class_name]).sample,
        faction: subject.faction,
        guild_name: 'Green Street Elite',
        level: subject.level + 1,
        max_ilvl: subject.max_ilvl + 1,
        min_ilvl: subject.min_ilvl + 1,
        name: 'Dargonaut',
        realm: 'Shadowmoon'
      )
    end

    it 'stores score and information from Armory::Character' do
      subject.update_from_armory(character, 100)

      expect(subject.new_record?).to eq(false)

      expect(subject.guild_name).to eq('Green Street Elite')
      expect(subject.name).to eq('Dargonaut')
      expect(subject.realm).to eq('Shadowmoon')
      expect(subject.score).to eq(100)

      %i(avg_ilvl class_name faction level max_ilvl min_ilvl).each do |field|
        expect(subject.public_send(field)).to eq(character.public_send(field))
      end
    end
  end
end
