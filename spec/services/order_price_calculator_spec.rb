# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderPriceCalculator do
  let(:order) { create(:order) }

  context 'when promotions and discounts are applied' do
    before do
      order.update(promotion_codes: ['2FOR1'], discount_code: 'SAVE5')
    end

    it 'calculates the total price with promotions' do
      # Mock promotions and discounts
      allow(order).to receive(:promotion_codes).and_return(['2FOR1'])
      allow(order).to receive(:discount_code).and_return('SAVE5')

      # Create an instance of the calculator
      calculator = described_class.new(order)

      # Perform calculation
      total_price = calculator.calculate_total_price

      # Expect the total price to be less than the sum of item base prices (no discounts)
      base_price = order.items.sum do |item|
        pizza_base_price = Rails.configuration.pizza_config['pizzas'][item.name] * Rails.configuration.pizza_config['size_multipliers'][item.size.capitalize]
        extra_ingredients_price = item.add.sum do |ingredient|
          Rails.configuration.pizza_config['ingredients'][ingredient] * Rails.configuration.pizza_config['size_multipliers'][item.size.capitalize]
        end
        pizza_base_price + extra_ingredients_price
      end

      expect(total_price).to be < base_price
    end
  end

  context 'when there are invalid promotion codes' do
    it 'handles invalid promotions gracefully' do
      order.update(promotion_codes: ['INVALID_PROMO'])
      calculator = described_class.new(order)
      expect { calculator.calculate_total_price }.not_to raise_error
    end
  end
end
