module Api

  class BoardsController < ApplicationController

    def new

    end

    def update

    end

    def edit

    end

    def show

    end

    def index
      if current_user
        own_boards = Board.where(:user_id => current_user.id)
        members = BoardMember.select("board_id,id").where(:user_id => current_user.id)
        arr = []

        members.each do |m|
          arr << Board.where(:id => m.board_id)
        end

        data = {:own_board => own_boards, :participate_boards => arr}
        response = data.to_json
        render :json => response
        return
      else
        response = 'DAPIE01'
      end
      render :json => response.to_json, :status => :forbidden

    end

    def create
      if current_user
        board =Board.new(:name => 'NewBoard', :wip => '10', :description => 'New Board', :user_id => current_user.id)
        board.save
        response = 'success'
        render :json => response.to_json
        return
      else
        response = 'DAPIE02'
      end
      render :json => response.to_json, :status => :forbidden
    end

    def destroy
      if current_user
        input = input_params
        board = Board.find(input[:id])
        if board.user_id != current_user.id
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

    def flows
      if current_user
        input = input_params
        board = Board.find(input[:id])
        member = BoardMember.where(:board_id => board.id, :user_id => current_user.id)
        if board.user_id != current_user.id || !member # if not board owner neither board member
          response = 'DAPIE04'
          render :json => response.to_json
          return
        end
        flows = Flow.where(:board_id => board.id)
        render :json => flows.to_json
        return
      else
        response = 'Not login'
        render :json => response.to_json, :status => :unauthorized
        return
      end
    end

    private
    def input_params
      {:id => params.require(:id)}
    end
  end
end