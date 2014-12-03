class BoardController < ApplicationController
  def index
    email = session[:login_user]
    email = email.downcase
    user = User::find_by_email(email)
    if user
      own_boards = Board.where(:user_id => user.id)
      members = BoardMember.select("board_id,id").where(:user_id => user.id)
      arr = []

      members.each do |m|
        arr << Board.where(:id => m.board_id)
      end

      data = {:own_board => own_boards,:participate_boards => arr}
      response = data.to_json
      render :json => response
      return
    else
      response = 'DAPIE01'
    end
    render :json => response.to_json , :status => :forbidden

  end

  def create
    email = session[:login_user]
    email = email.downcase
    user = User::find_by_email(email)

    if user
      board =Board.new(:name => 'NewBoard',:wip =>'10',:description =>'New Board',:user_id => user.id)
      board.save
      response = 'success'
      render :json => response.to_json
      return
    else
      response = 'DAPIE02'
    end
    render :json => response.to_json ,:status => :forbidden
  end

  def destroy
    email = session[:login_user]
    email = email.downcase
    user = User::find_by_email(email)

    if user
      input = input_params
      board = Board.find(input[:id])
      if board.user_id != user.id
        response = 'DAPIE03'
        render :json => response.to_json
        return
      end
      board.destroy
      response = 'delete success'
    else
      response = 'Not login'
      render :json => response.to_json, :status => :unauthorized
      return
    end
    render :json => response.to_json
  end

  private

  def input_params
    {:id => params.require(:id)}
  end
end
