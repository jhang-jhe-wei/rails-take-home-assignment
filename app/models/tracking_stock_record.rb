class TrackingStockRecord < ApplicationRecord
  belongs_to :tracking_list
  belongs_to :stock
end
