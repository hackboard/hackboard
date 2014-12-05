class UserController < ApplicationController

  def login
    input = login_params
    email = input[:email]
    password = input[:password]

    user = User::find_by_email email

    if user
      if user.authenticate(password)
        session[:login_user] = email
        response = 'success'
        render :json => response.to_json
        return
      else
        response = 'UMSE01'
      end
    else
      response = 'UMSE02'
    end
    render :json => response.to_json , status: :forbidden
  end


  #1. 輸入是空的會彈出錯誤
  #2.
  #
  def register
    input = register_params

    name = input[:name]
    email = input[:email]
    password = input[:password]
    password_confirmation = input[:password_confirmation]

    unless password == password_confirmation
      response = 'UMSE04'
    else
      if User::find_by_email email
        response = 'UMSE03'
      else
        user = User.new(:email => email,:name =>name,:password => password,:sign_in_count => 0)
        user.save
        response = 'success'
      end
    end

    render :json => response.to_json

  end

  private

  def register_params
    {
        :name => params.require(:name),
        :email => params.require(:email),
        :password => params.require(:password),
        :password_confirmation => params.require(:password_confirmation)
    }
  end

  def login_params
    {
        :email => params.require(:email),
        :password => params.require(:password)
    }
  end

end
