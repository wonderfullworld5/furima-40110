require 'rails_helper'
require 'faker'

RSpec.describe Item, type: :model do
  describe 'validations' do
    before do
      @item = FactoryBot.build(:item)
    end

    context 'when all attributes are valid' do
      it 'is valid with valid attributes' do
        expect(@item).to be_valid
      end
    end

    context 'when attributes are invalid' do
      it 'is not valid without a name' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'is not valid without a description' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'is not valid without a category' do
        @item.category = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'is not valid without a condition' do
        @item.condition = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'is not valid without a shipping_fee' do
        @item.shipping_fee = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end

      it 'is not valid without a prefecture' do
        @item.prefecture = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'is not valid without shipping_days' do
        @item.shipping_days = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping days can't be blank")
      end

      it 'is not valid without a price' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'is not valid with a price less than 300' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'is not valid with a price greater than 9,999,999' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it 'is not valid with a non-numeric price' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
