# frozen_string_literal: true

class CreateTrackingLists < ActiveRecord::Migration[6.1]
  def change
    create_table :tracking_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :row_order
      t.string :name

      t.timestamps
    end
  end
end
