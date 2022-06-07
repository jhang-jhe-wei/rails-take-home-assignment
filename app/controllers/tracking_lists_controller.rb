# frozen_string_literal: true

class TrackingListsController < ApplicationController
  before_action :set_tracking_list, only: %i[edit update destroy down up]

  def index
    @tracking_lists = current_user.tracking_lists.includes(:stocks).order(row_order: :DESC)
  end

  def new
    @tracking_list = current_user.tracking_lists.build
  end

  def create
    @tracking_list = current_user.tracking_lists.new(tracking_list_params)
    if @tracking_list.save
      redirect_to tracking_lists_path, notice: '追蹤清單已建立'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @tracking_list.update(tracking_list_params)
      redirect_to tracking_lists_url, notice: '追蹤清單已成功修改'
    else
      render :edit
    end
  end

  def destroy
    @tracking_list.destroy
    redirect_to tracking_lists_url, notice: '追蹤清單已成功刪除'
  end

  def down
    @tracking_list.down
    redirect_to tracking_lists_url
  end

  def up
    @tracking_list.up
    redirect_to tracking_lists_url
  end

  private

  def tracking_list_params
    params.require(:tracking_list).permit(:name)
  end

  def set_tracking_list
    @tracking_list = current_user.tracking_lists.find(params[:id])
  end
end
