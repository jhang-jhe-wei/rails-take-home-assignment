class TrackingStockRecordsController < ApplicationController
  before_action :set_tracking_list, only: [:new, :create]

  def new
    @tracking_stock_record = @tracking_list.tracking_stock_records.build
  end

  def create
    tracking_stock_record = TrackingStockRecord.new(
      tracking_list_id: @tracking_list.id,
      stock_id: Stock.find_by_code(params[:tracking_stock_record][:code])&.id
    )
    if tracking_stock_record.save
      redirect_to tracking_lists_url, notice: "已加入追蹤清單"
    else
      redirect_to tracking_lists_url, alert: tracking_stock_record.errors.full_messages
    end
  end

  private
  def set_tracking_list
    @tracking_list = current_user.tracking_lists.find(params[:tracking_list_id])
  end
end
