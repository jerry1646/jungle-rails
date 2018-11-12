require 'rails_helper'

RSpec.describe User, type: :model do

  subject { described_class.new(first_name: "New", last_name: "User",
        email: "example@example.com", password: "123", password_confirmation: "123") }


  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a first name" do
      subject.first_name = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without a last name" do
      subject.last_name = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without a password confirmation" do
      subject.password_confirmation = nil
      expect(subject).not_to be_valid
    end

    it "is not valid when password doesn't match password confirmation" do
      subject.password = "SomethingElse"
      expect(subject).not_to be_valid
    end

    it "is not valid when email is not unique" do
      described_class.create(first_name: "New", last_name: "User",
        email: "example@example.com", password: "123", password_confirmation: "123")
      expect(subject).not_to be_valid
    end

    it "is not valid when email is not the right format" do
      subject.email = "SomethingElse"
      expect(subject).not_to be_valid
    end

    it "is not valid when email is not the right format" do
      subject.email = "SomethingElse.com"
      expect(subject).not_to be_valid
    end

    it "is not valid when email is not the right format" do
      subject.email = "Something@.com"
      expect(subject).not_to be_valid
    end

    it "is not valid when password is less than 3 characters" do
      subject.password = "12"
      subject.password_confirmation = "12"
      expect(subject).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "should log user in given the correct credentials" do
      described_class.create(first_name: "New", last_name: "User",
          email: "example@test.com", password: "123", password_confirmation: "123")
      result = User.authenticate_with_credentials("  example@test.COM  ", "123")
      expect(result).to eq User.find_by(email: "example@test.com")
    end

    it "should not allow log-in requests without correct credentials" do
      described_class.create(first_name: "New", last_name: "User",
          email: "example@test.com", password: "123", password_confirmation: "123")
      result = User.authenticate_with_credentials("example@test.com", "somethingwrong")
      expect(result).not_to eq User.find_by(email: "example@test.com")
    end
  end

end
