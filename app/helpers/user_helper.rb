module UserHelper
  def current_user
    if session.include?(:login_user)
      email = session[:login_user]
      user = User.find_by_email email
      return user
    end
  end
end
