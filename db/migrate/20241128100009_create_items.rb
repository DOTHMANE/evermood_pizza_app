# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items, id: :uuid do |t|
      t.string :name
      t.integer :size, null: false
      t.string :add, array: true, default: []
      t.string :remove, array: true, default: []
      t.references :order, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
