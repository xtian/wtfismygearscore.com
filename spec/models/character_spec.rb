# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Character do
  subject { Fabricate.build(:character, updated_at: Time.current) }

  it { is_expected.to define_enum_for(:class_name).with(CLASSES) }
  it { is_expected.to define_enum_for(:faction).with(FACTIONS) }
  it { is_expected.to define_enum_for(:region).with(VALID_REGIONS_WITH_REALM) }
  it { is_expected.to validate_numericality_of(:level).only_integer.is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:score).only_integer }

  %i[api_updated_at avg_ilvl class_name level max_ilvl min_ilvl name realm region score].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end

  %i[avg_ilvl max_ilvl min_ilvl].each do |field|
    it { is_expected.to validate_numericality_of(field).only_integer.is_greater_than_or_equal_to(0) }
  end

  it { is_expected.to have_db_index(%i[name realm region]).unique }
  it { is_expected.to have_db_index(%i[score region realm name]) }

  describe '.from_params' do
    params = { region: 'us', realm: 'shadowmoon', name: 'dargonaut' }

    params.each_key do |key|
      it "requires #{key} to be passed" do
        invalid_params = params.without(key)

        expect {
          described_class.from_params(invalid_params)
        }.to raise_error(ArgumentError)
      end
    end

    it 'returns a character for the passed params' do
      character = Fabricate(:character, params)
      found = described_class.from_params(params)

      expect(found).to eq(character)
    end

    it 'returns a character using a translated realm' do
      Realm.create!(name: params[:realm], translations: [params[:realm].reverse])
      character = Fabricate(:character, params)

      found = described_class.from_params(
        name: params[:name],
        realm: params[:realm].reverse,
        region: params[:region]
      )

      expect(found).to eq(character)
    end

    it 'returns a new character if one is not cached for params' do
      found = described_class.from_params(params)

      expect(found.new_record?).to eq(true)
    end
  end

  describe '#comments_count' do
    it 'returns the number of comments' do
      allow(subject.comments).to receive(:count).and_return(1)
      expect(subject.comments_count).to eq(1)
    end
  end

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

    it 'handles negative median scores' do
      median = instance_double('MedianGearscore', median_score: -20)
      allow(MedianGearscore).to receive(:find_or_initialize_by).with(level: 1) { median }

      winner = Fabricate.build(:character, level: 1, score: -10)
      failure = Fabricate.build(:character, level: 1, score: -30)

      expect(winner.median_difference).to eq(10)
      expect(failure.median_difference).to eq(-10)
    end
  end

  describe '#update_from_armory' do
    let(:character) do
      instance_double(
        'Armory::Character',
        avg_ilvl: subject.avg_ilvl + 1,
        class_name: (CLASSES - [subject.class_name]).sample,
        faction: (FACTIONS - [subject.faction]).sample,
        guild_name: 'Green Street Elite',
        last_modified: subject.updated_at - 1.day,
        level: subject.level + 1,
        max_ilvl: subject.max_ilvl + 1,
        min_ilvl: subject.min_ilvl + 1,
        name: 'Dargonaut',
        realm: 'Shadowmoon'
      )
    end

    before do
      subject.update_from_armory(character, 100)
    end

    it 'stores score and information from Armory::Character' do
      expect(subject.new_record?).to eq(false)

      expect(subject.api_updated_at).to eq(subject.updated_at - 1.day)
      expect(subject.guild_name).to eq('Green Street Elite')
      expect(subject.name).to eq('Dargonaut')
      expect(subject.realm).to eq('Shadowmoon')
      expect(subject.score).to eq(100)

      %i[avg_ilvl class_name faction level max_ilvl min_ilvl].each do |field|
        expect(subject.public_send(field)).to eq(character.public_send(field))
      end
    end

    it 'does not raise error for duplicate records' do
      duplicate = described_class.new(
        name: subject.name,
        realm: subject.realm,
        region: subject.region
      )

      expect { duplicate.update_from_armory(character, 100) }.not_to raise_error
    end

    it 'handles saved records' do
      subject.update! updated_at: 1.week.ago

      expect {
        subject.update_from_armory(character, 100)
      }.not_to raise_error

      expect(subject.updated_at).to be > 1.week.ago
    end
  end
end
