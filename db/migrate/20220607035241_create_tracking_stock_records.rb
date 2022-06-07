# frozen_string_literal: true

class CreateTrackingStockRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :tracking_stock_records do |t|
      t.references :tracking_list, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
