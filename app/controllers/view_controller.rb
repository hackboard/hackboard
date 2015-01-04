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

end
