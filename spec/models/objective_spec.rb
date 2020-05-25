require 'rails_helper'

RSpec.describe Objective, type: :model do
  subject { described_class.create(name: 'Event Name', start_time: Time.current - 1, end_time: Time.current) }
  context 'creation' do 
    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end
    it "is not valid without a name" do
        subject.name = nil
        expect(subject).to_not be_valid
    end
    it "is not valid without a start_time" do
        subject.start_time = nil
        expect(subject).to_not be_valid
    end
    it "is not valid without an end_time" do
        subject.end_time = nil
        expect(subject).to_not be_valid
    end
    it "is not valid if end time is before start time" do
        subject.end_time = subject.start_time - 1
        expect(subject).to_not be_valid
    end
  end

  context 'reading attributes' do
    it 'will return its duration' do
      start_time = Time.now  
      end_time = Faker::Time.forward(days: 1)
      duration = end_time - start_time
      subject.start_time = start_time
      subject.end_time = end_time
      subject.save
      expect(subject.duration).to eq duration
    end

  end
end
