# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'

file_path = Rails.root.join('data/orders.json')
orders = JSON.parse(File.read(file_path))

orders.each do |order_data|
  order = Order.create!(
    state: order_data['state'].upcase,
    promotion_codes: order_data['promotionCodes'],
    discount_code: order_data['discountCode']
  )

  order_data['items'].each do |item_data|
    order.items.create!(
      name: item_data['name'],
      size: item_data['size'].downcase,
      add: item_data['add'],
      remove: item_data['remove']
    )
  end
end
