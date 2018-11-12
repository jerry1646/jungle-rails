require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new(name: "New Category")
    end

    it "is valid with valid attributes" do
      @product = described_class.new(name: "Something", price: 300, quantity: 20, category: @category)
      expect(@product).to be_valid
      expect(@product.errors.full_messages.length).to eq 0
      puts @product.errors.full_messages
    end

    it "is not valid without a name" do
      @product = described_class.new(price: 300, quantity: 20, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages.length).to be > 0
    end

    it "is not valid without a price" do
      @product = described_class.new(name: "Something", quantity: 20, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages.length).to be > 0
    end

    it "is not valid without a quantity" do
      @product = described_class.new(name: "Something", price: 300, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages.length).to be > 0
    end

    it "is not valid without a category" do
      @product = described_class.new(name: "Something", price: 300, quantity: 20)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages.length).to be > 0
    end


  end

end
