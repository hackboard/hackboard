class ViewController < ApplicationController

  def index
    check_remember
  end

  def check_remember
    if not cookies[:remember_token].nil?
      if not current_user.nil?
        #refresh remember token
        remember @current_user
        redirect_to '/boards'
      else
        Rails.logger.debug('No current user...')
      end
    end
  end

  def boards
    if current_user
      @board = current_user.myBoards
    else
      redirect_to '/'
    end
  end

  def board
    if current_user
      id = params[:id].to_i
      @board = Board::find(id)
      unless @board
        redirect_to '/boards'
      end
    else
      redirect_to '/boards'
    end
  end

end
