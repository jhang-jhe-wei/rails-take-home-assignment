class TrackingStockRecordsController < ApplicationController
  before_action :set_tracking_list, only: [:new, :create]

  def index
    redirect_to new_tracking_list_tracking_stock_record_url
  end

  def new
    @tracking_stock_record = @tracking_list.tracking_stock_records.build
  end

  def create
    @tracking_stock_record = TrackingStockRecord.new(
      tracking_list_id: @tracking_list.id,
      stock_id: Stock.find_by_code(params[:tracking_stock_record][:code])&.id
    )
    if @tracking_stock_record.save
      redirect_to tracking_lists_url, notice: "已加入追蹤清單"
    else
      render :new
    end
  end

  private
  def set_tracking_list
    @tracking_list = current_user.tracking_lists.find(params[:tracking_list_id])
  end
end
