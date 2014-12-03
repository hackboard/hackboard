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
    render :json => response , :status => :forbidden

  end
end
