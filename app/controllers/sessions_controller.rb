# frozen_string_literal: true

class SessionsController < ApplicationController
  def switch_user
    session[:current_user_id] = params[:user_id]
    redirect_to root_url
  end
end
