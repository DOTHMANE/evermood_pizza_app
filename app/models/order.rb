# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :items, dependent: :destroy

  enum state: { COMPLETE: 1, OPEN: 0 }

  validates :state, presence: true
end
