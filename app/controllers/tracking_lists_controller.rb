# frozen_string_literal: true

class TrackingListsController < ApplicationController
  def index
    @tracking_lists = current_user.tracking_lists.all
  end

  def new
    @tracking_list = current_user.tracking_lists.build
  end

  def create
    @tracking_list = current_user.tracking_lists.new(tracking_list_params)
    if @tracking_list.save
      redirect_to tracking_lists_path, notice: "追蹤清單已建立"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def tracking_list_params
    params.require(:tracking_list).permit(:name)
  end
end
