require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    subject { described_class.new(name: "Something", price: 300, quantity: 20) }

    before(:each) do
      @category = Category.new(name: "New Category")
      subject.category = @category
    end

    it "is valid with valid attributes" do
      expect(subject).to be_valid
      expect(subject.errors.full_messages.length).to eq 0
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages.length).to be > 0
    end

    it "is not valid without a price" do
      subject.price_cents = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages.length).to be > 0
    end

    it "is not valid without a quantity" do
      subject.quantity = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages.length).to be > 0
    end

    it "is not valid without a category" do
      subject.category = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages.length).to be > 0
    end


  end

end
