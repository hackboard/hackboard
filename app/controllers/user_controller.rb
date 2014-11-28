class UserController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root, :notice => "Sign up"
    else
      render new
    end
  end

  def update

  end

  def destroy

  end
end
