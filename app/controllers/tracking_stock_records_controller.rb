class TrackingStockRecordsController < ApplicationController
  before_action :set_tracking_list, only: [:new]

  def new
    @tracking_stock_record = @tracking_list.tracking_stock_records.build
  end

  private
  def set_tracking_list
    @tracking_list = current_user.tracking_lists.find(params[:tracking_list_id])
  end
end
