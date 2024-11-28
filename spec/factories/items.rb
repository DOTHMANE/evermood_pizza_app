# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { 'Margherita' }
    size { 'medium' }
    add { [] }
    remove { [] }
    association :order
  end
end
