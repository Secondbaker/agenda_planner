require 'rails_helper'

RSpec.describe AgendaEvent, type: :model do
    subject { described_class.new(name: 'Event Name', start_time: Time.current - 1, end_time: Time.current) }
    
    it "is valid with valid attributes" do
        puts subject.inspect
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
    it "is valid if end time is before start time" do
        subject.end_time = subject.start_time - 1
        expect(subject).to be_valid
    end
  end