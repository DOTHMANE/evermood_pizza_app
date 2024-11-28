# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Order Management', type: :feature do
  let!(:open_order) { create(:order, state: 'OPEN') }
  let!(:completed_order) { create(:order, state: 'COMPLETE') }

  scenario 'User views only open orders' do
    visit orders_path
    expect(page).to have_content(open_order.id)
    expect(page).not_to have_content(completed_order.id)
  end

  scenario 'User completes an order' do
    visit orders_path
    within("##{open_order.id}") do
      click_button 'Complete'
    end
    expect(page).not_to have_content(open_order.id)
    expect(page).to have_content('No open orders available.') if Order.where(state: 'OPEN').empty?
  end

  scenario 'User sees message when all orders are completed' do
    open_order.update(state: 'COMPLETE')
    visit orders_path
    expect(page).to have_content('No open orders available.')
  end
end
