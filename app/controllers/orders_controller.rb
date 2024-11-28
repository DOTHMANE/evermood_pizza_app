# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: [:update]
  # GET /orders
  def index
    @orders = Order.where(state: 'OPEN')
  end

  def update
    @order.update(state: 1)
    redirect_to orders_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
