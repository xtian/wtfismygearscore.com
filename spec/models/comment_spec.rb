require 'rails_helper'

RSpec.describe Comment do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:poster_ip_address) }

  it { should validate_length_of(:body).is_at_most(1000) }
  it { should validate_length_of(:poster_name).is_at_most(15) }

  it { should have_db_index([:character_id, :created_at]) }

  %i(body poster_name).each do |field|
    method_name = "#{field}="

    describe "##{method_name}" do
      it 'strips whitespace from value' do
        subject.public_send(method_name, nil)
        expect(subject.public_send(field)).to eq(nil)

        subject.public_send(method_name, '')
        expect(subject.public_send(field)).to eq(nil)

        subject.public_send(method_name, ' ')
        expect(subject.public_send(field)).to eq(nil)

        subject.public_send(method_name, ' value ')
        expect(subject.public_send(field)).to eq('value')
      end
    end
  end
end
