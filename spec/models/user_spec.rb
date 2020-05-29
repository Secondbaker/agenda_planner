require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new }
  context 'creating user' do
    it 'with proper information succeeds' do
      subject.email = Faker::Internet.email
      subject.password = 'password'
      subject.save
      expect(User.all.size).to eq 1
    end
    it 'with no information fails' do
      subject.save
      expect(User.all.size).to eq 0
    end
    it 'without email fails' do
      subject.password = 'password'
      subject.save
      expect(User.all.size).to eq 0
    end
  end
end
