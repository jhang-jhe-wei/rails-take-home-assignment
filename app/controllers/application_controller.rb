# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user
  def authenticate_user
    @current_user = User.find_by_id(session[:current_user_id]) || User.first
  end

  protected
  def current_user
    @current_user
  end
end
