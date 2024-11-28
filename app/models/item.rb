# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :order

  # Define enum for size
  enum size: { small: 0, medium: 1, large: 2 }
end
