# frozen_string_literal: true

module SessionsHelper
  def all_users_options
    options_for_select(User.all.map { |user| [user.name, user.id] }, session[:current_user_id])
  end
end
