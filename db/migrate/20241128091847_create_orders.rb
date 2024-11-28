# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.integer :state, null: false, default: 0
      t.string :promotion_codes, array: true, default: []
      t.string :discount_code

      t.timestamps
    end

    add_index :orders, :state
  end
end
