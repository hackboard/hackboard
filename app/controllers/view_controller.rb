class ViewController < ApplicationController

  def index
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
