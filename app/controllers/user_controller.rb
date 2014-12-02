class UserController < ApplicationController


  def new
  end

  def login
    email = params[:email]
    password = params[:password]

    user = User::find_by_email email

    if user
      if user.authenticate(password)
        session[:login_user] = email
        response = 'success'
      else
        response = 'UMSE01'
      end
    else
      response = 'UMSE02'
    end
    render :json => response.to_json
  end

  def update

  end

  def destroy

  end
end
