require 'rails_helper'

RSpec.describe Character do
  subject { Fabricate.build(:character) }

  it { should define_enum_for(:class_name).with(CLASSES) }
  it { should define_enum_for(:region).with(VALID_REGIONS_WITH_REALM) }

  %i(avg_ilvl class_name level max_ilvl min_ilvl name realm region score).each do |field|
    it { should validate_presence_of(field) }
  end

  %i(avg_ilvl level max_ilvl min_ilvl score).each do |field|
    it { should validate_numericality_of(field).only_integer.is_greater_than(0) }
  end

  it { should have_db_index([:name, :realm, :region]).unique }
  it { should have_db_index([:realm, :region, :score]) }
  it { should have_db_index([:region, :score]) }
  it { should have_db_index(:score) }

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

  describe '#update_from_armory' do
    it 'stores score and information from Armory::Character' do
      fields = %i(avg_ilvl class_name level max_ilvl min_ilvl name realm)

      armory_character = instance_double('Armory::Character', subject.slice(*fields))
      allow(armory_character).to receive(:guild_name).and_return('Green Street Elite')

      subject.update_from_armory(armory_character, 100)

      expect(subject.new_record?).to eq(false)
      expect(subject.score).to eq(100)
      expect(subject.guild_name).to eq('Green Street Elite')
    end
  end
end
