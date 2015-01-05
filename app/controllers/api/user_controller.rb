module Api

  class UserController < ApplicationController

    protect_from_forgery with: :exception, except: :logout

    def login
      input = login_params
      email = input[:email]
      email = email.downcase
      password = input[:password]
      remember_me = input[:remember_me]

      user = User::find_by_email email

      if user
        if user.authenticate(password)
          session[:login_user] = email
          if remember_me
            remember user
          end
          response = 'success'
          render :json => response.to_json
          return
        else
          response = 'UMSE01'
        end
      else
        response = 'UMSE02'
      end
      render :json => response.to_json, status: :forbidden
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
          user = User.new(:email => email, :name => name, :password => password, :sign_in_count => 0)
          user.save
          response = 'success'
          render :json => response.to_json
          return
        end
      else
        response = 'UMSE04'
      end

      render :json => response.to_json, :status => :forbidden

    end

    def logout
      if session.has_key? :login_user
        session.delete :login_user
        if cookies.has_key? :login_user and cookies.has_key? :remember_token
          forget @current_user
        end
        render :json => 'success'.to_json
      else
        render :json => 'UMSE05'.to_json
      end
    end

    def forget(user)
      user.forget
      cookies.delete(:login_user)
      cookies.delete(:remember_token)
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
          :password => params.require(:password),
          :remember_me => params.require(:remember_me)
      }
    end

  end

end
