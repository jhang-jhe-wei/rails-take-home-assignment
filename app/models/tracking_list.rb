class TrackingList < ApplicationRecord
  belongs_to :user
  before_create :calculate_row_order

  def down
    TrackingList.transaction do
      current_order = self.row_order
      if last_smaller_order_tracking_list
        self.update!(row_order: last_smaller_order_tracking_list.row_order)
        last_smaller_order_tracking_list.update!(row_order: current_order)
      end
    end
  end

  private
  def calculate_row_order
    max_order = TrackingList.where(user_id: user_id).order(row_order: :DESC).first&.row_order
    if max_order
      # 該使用者目前有追蹤清單
      self.row_order = max_order + 1
    else # 該使用者目前沒有追蹤清單
      self.row_order = 1
    end
  end

  def last_smaller_order_tracking_list
    @last_smaller_order_tracking_list ||= user.tracking_lists.where("row_order < ?", self.row_order).order(:row_order).last
  end
end
