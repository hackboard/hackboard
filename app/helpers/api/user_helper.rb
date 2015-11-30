module Api::UserHelper

  def remember(user)
    user.remember
    cookies.permanent.signed[:login_user] = user.email
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  def current_user
    # 不太清楚這邊的邏輯
    @current_user = nil
    if session.include?(:login_user)
      email = session[:login_user]
      @current_user ||= User.find_by_email email
    elsif email == cookies.signed[:login_user]
      user = User.find_by_email email
      if user && user.authenticated?(cookies[:remember_token])
        session[:login_user] = user.email
        @current_user = user
      end
    end
  end

end
