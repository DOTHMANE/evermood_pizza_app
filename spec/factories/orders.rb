# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    state { 'OPEN' }
    created_at { Time.current }
    promotion_codes { [] }
    discount_code { nil }

    # Add associated items to the order after creation
    after(:create) do |order|
      create_list(:item, 3, order: order)
    end
  end
end
