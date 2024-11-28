# frozen_string_literal: true

class OrdersController < ApplicationController
  # GET /orders
  def index
    @orders = Order.where(state: 'COMPLETE')
  end
end
