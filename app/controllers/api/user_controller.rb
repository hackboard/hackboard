class Api::UserController < ApplicationController

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
      if cookies.has_key? :login_user and cookies.has_key? :remember_token
        current_user
        forget @current_user
      end
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

  def forget(user)
    user.forget
    cookies.delete(:login_user)
    cookies.delete(:remember_token)
  end

  def current
    render :json => current_user.to_json
  end

  def find
    name = params[:name]
    q = "%#{name}%"
    users = User.where('name like ? or email like ?', q, q).select(:id, :email, :name)
    render json: users.to_json
  end

  def save
    name = params[:name]
    id = params[:id]
    user = User.find(id)
    user.name = name
    user.save()

    # @todo
    # send user update to redis

    render json: "ok".to_json

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
