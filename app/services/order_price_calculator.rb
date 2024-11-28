# frozen_string_literal: true

class OrderPriceCalculator
  def initialize(order)
    @order = order
  end

  def calculate_total_price
    base_price = calculate_base_price
    promotion_price = apply_promotions(base_price)
    final_price = apply_discount(promotion_price)
    [final_price.round(2), 0].max # Ensure price is not below zero
  end

  private

  def config
    @config ||= Rails.configuration.pizza_config
  end

  def size_multipliers
    @size_multipliers ||= config['size_multipliers']
  end

  def pizza_prices
    @pizza_prices ||= config['pizzas']
  end

  def ingredient_prices
    @ingredient_prices ||= config['ingredients']
  end

  def promotions
    @promotions ||= config['promotions']
  end

  def discounts
    @discounts ||= config['discounts']
  end

  # Calculate base price for all items in the order
  def calculate_base_price
    @order.items.sum do |item|
      pizza_base_price = pizza_prices[item.name] * size_multiplier(item.size)
      extra_ingredients_price = item.add.sum { |ingredient| ingredient_prices[ingredient] * size_multiplier(item.size) }
      pizza_base_price + extra_ingredients_price
    end
  end

  # Apply any promotions to the base price
  def apply_promotions(total)
    @order.promotion_codes.each do |promo_code|
      promotion = promotions[promo_code]
      next unless promotion

      total -= calculate_promotion_discount(promotion)
    end
    total
  end

  # Calculate the discount amount for a promotion
  def calculate_promotion_discount(promotion)
    target_pizza = promotion['target']
    target_size = promotion['target_size'].capitalize
    from_quantity = promotion['from']
    to_quantity = promotion['to']

    eligible_items = @order.items.select { |item| item.name == target_pizza && item.size.capitalize == target_size }
    sets_of_promo = eligible_items.size / from_quantity

    sets_of_promo * (from_quantity - to_quantity) * pizza_prices[target_pizza] * size_multiplier(target_size)
  end

  # Apply discount code to the total price
  def apply_discount(total)
    discount_code = @order.discount_code
    return total unless discount_code && discounts[discount_code]

    deduction_percent = discounts[discount_code]['deduction_in_percent']
    total * (1 - deduction_percent / 100.0)
  end

  # Get the multiplier for a pizza size
  def size_multiplier(size)
    size_multipliers[size.capitalize] || 1
  end
end
