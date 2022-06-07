# frozen_string_literal: true

class TrackingList < ApplicationRecord
  belongs_to :user
  before_create :calculate_row_order
  has_many :tracking_stock_records, dependent: :destroy
  has_many :stocks, through: :tracking_stock_records

  def down
    TrackingList.transaction do
      current_order = row_order
      list = last_smaller_order_tracking_list
      if list
        update!(row_order: list.row_order)
        list.update!(row_order: current_order)
      end
    end
  end

  def up
    TrackingList.transaction do
      current_order = row_order
      list = first_bigger_order_tracking_list
      if list
        update!(row_order: list.row_order)
        list.update!(row_order: current_order)
      end
    end
  end

  private

  def calculate_row_order
    max_order = TrackingList.where(user_id: user_id).order(row_order: :DESC).first&.row_order
    self.row_order = if max_order
                       # 該使用者目前有追蹤清單
                       max_order + 1
                     else # 該使用者目前沒有追蹤清單
                       1
                     end
  end

  def last_smaller_order_tracking_list
    user.tracking_lists.where('row_order < ?', row_order).order(:row_order).last
  end

  def first_bigger_order_tracking_list
    user.tracking_lists.where('row_order > ?', row_order).order(:row_order).first
  end
end
