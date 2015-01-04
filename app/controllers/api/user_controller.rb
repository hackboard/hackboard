module Api

  class UserController < ApplicationController

    protect_from_forgery with: :exception, except: :logout

    def login
      input = login_params
      email = input[:email]
      email = email.downcase
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
        respond_to do |format|
          format.html {
            redirect_to '/'
          }
          format.json {
            'success'.to_json
          }
        end

      else
        render :json => 'UMSE05'.to_json
      end
    end

    def pin_board
      board_id = params[:board_id].to_i
      myboard = current_user.myBoards
      myboard[:other].each do |b|
        if b.id.equal? board_id
          current_user.pin_boards << b
          render :json => {
                     :response => 'success'
                 }
          return
        end
      end
      render :json => {
                 :response => 'fail'
             }
    end

    def unpin_board
      board_id = params[:board_id].to_i
      myboard = current_user.myBoards
      myboard[:pin].each do |b|
        if b.id.equal? board_id
          current_user.pin_boards.delete(b)
          break
        end
      end
      render :json => current_user.myBoards
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

end
