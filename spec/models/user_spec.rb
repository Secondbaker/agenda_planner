require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user = User.new
            user.password = 'password'
            user.email = Faker::Internet.email
            user }
  context 'creating user' do
    it 'with proper information succeeds' do
      subject.save
      expect(User.all.size).to eq 1
    end
    it 'fails if the email is not an actual email address' do
      subject.email = 'nope'
      subject.save
      expect(User.all.size).to eq 0
    end
    it 'with no information fails' do
      subject.password = nil
      subject.email = nil
      subject.save
      expect(User.all.size).to eq 0
    end
    it 'without email fails' do
      subject.email = nil
      subject.save
      expect(User.all.size).to eq 0
    end
  end
  context 'confirming email' do
    it 'sends confimation email' do
      subject.save
      expect(subject.confirmation_sent_at).to_not be_nil
    end
  end
end
