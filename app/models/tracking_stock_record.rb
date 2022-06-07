# frozen_string_literal: true

class TrackingStockRecord < ApplicationRecord
  belongs_to :tracking_list
  belongs_to :stock
  validates_associated :tracking_list, :stock
  validate :the_list_cannot_have_the_same_stock_number

  private

  def the_list_cannot_have_the_same_stock_number
    errors.add(:stock_id, 'aleady exists') if tracking_list.stocks.find_by(id: stock_id)
  end
end
