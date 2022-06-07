# frozen_string_literal: true

class Stock < ApplicationRecord
  has_many :tracking_stock_records, dependent: :destroy
  has_many :tracking_lists, through: :tracking_stock_records
end
