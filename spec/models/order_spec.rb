# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:state) }
  end

  describe 'associations' do
    it { should have_many(:items) }
  end

  describe '#total_price' do
    let(:order) { create(:order, promotion_codes: ['2FOR1'], discount_code: 'SAVE5') }

    it 'calculates the total price using OrderPriceCalculator' do
      calculator = instance_double(OrderPriceCalculator, calculate_total_price: 25.0)
      allow(OrderPriceCalculator).to receive(:new).with(order).and_return(calculator)

      expect(order.total_price).to eq(25.0)
    end
  end
end
