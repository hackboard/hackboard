class UserController < ApplicationController




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


  def register
    input = register_params

    name = input[:name]
    email = input[:email]
    email = email.downcase
    password = input[:password]
    password_confirmation = input[:password_confirmation]


    if password == password_confirmation
      if User::find_by_email email
        response = 'UMSE03'
      else
        user = User.new(:email => email,:name =>name,:password => password,:sign_in_count => 0)
        user.save
        response = 'success'
        render :json => response.to_json
        return
      end
    else
      response = 'UMSE04'
    end

    render :json => response.to_json , :status => :forbidden

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
end
