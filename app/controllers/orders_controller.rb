# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: [:update]
  # GET /orders
  def index
    @orders = Order.where(state: 'OPEN').includes(:items)
  end

  def update
    @order.update(state: 1)
    # Render a Turbo Stream to replace the completed order
    respond_to do |format|
      format.html { redirect_to orders_path }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@order.id.to_s, partial: 'orders/complete_order',
                                                                  locals: { order: @order })
      end
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
