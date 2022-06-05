# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user
  def authenticate_user
    @current_user = User.find_by(id: session[:current_user_id]) || User.first
  end

  protected

  attr_reader :current_user
end
