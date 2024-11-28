# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let!(:open_order) { create(:order, state: 'OPEN') }
  let!(:completed_order) { create(:order, state: 'COMPLETE') }

  describe 'GET #index' do
    it 'assigns only open orders to @orders' do
      get :index
      expect(assigns(:orders)).to eq([open_order])
    end
  end

  describe 'PATCH #update' do
    it 'updates the order state to COMPLETE' do
      patch :update, params: { id: open_order.id }, format: :turbo_stream
      expect(open_order.reload.state).to eq('COMPLETE')
    end

    it 'renders the correct turbo_stream response' do
      patch :update, params: { id: open_order.id }, format: :turbo_stream
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
    end
  end
end
