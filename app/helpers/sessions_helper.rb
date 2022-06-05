module SessionsHelper
  def all_users_options
    options_for_select(User.all.map{ |user| [user.name, user.id] }, @current_user.id)
  end
end
