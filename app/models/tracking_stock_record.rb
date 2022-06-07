class TrackingStockRecord < ApplicationRecord
  belongs_to :tracking_list
  belongs_to :stock
  validates_associated :tracking_list, :stock
end
