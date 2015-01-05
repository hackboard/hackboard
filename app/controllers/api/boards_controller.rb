module Api

  class BoardsController < ApplicationController

    def new

    end

    def update

    end

    def edit

    end

    def show
      board_id = params[:id]
      unless current_user
        render :json => 'ERROR'.to_json
        return
      end
      board = current_user.getBoard(board_id)
      if board
        render :json => current_user.getBoard(board_id).to_json(include: :users)
      else
        render :json => 'ERROR'.to_json
      end
    end

    def index
      if current_user
        data = current_user.myBoards
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
        board = Board.new(:name => 'NewBoard', :wip => '10', :description => 'New Board', :user_id => current_user.id)
        board.save

        Flow.create(:name => 'ToDo', order: 1, max_task: 5, max_day: 5, board_id: board.id)
        Flow.create(:name => 'Doing', order: 2, max_task: 5, max_day: 5, board_id: board.id)
        Flow.create(:name => 'Done', order: 3, max_task: 5, max_day: 5, board_id: board.id)

        response = 'success'
        render :json => {
                   :response => response,
                   :board => board
               }.to_json
        return
      else
        response = 'DAPIE02'
      end
      render :json => {:error => response}.to_json, :status => :forbidden
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
        board = current_user.getBoard(input[:id])
        member = BoardMember.where(:board_id => board.id, :user_id => current_user.id)
        if board.user_id != current_user.id || !member # if not board owner neither board member
          response = 'DAPIE04'
          render :json => response.to_json
          return
        end
        flows = board.flows
        render :json => flows.to_json( include:[:tasks , { :flows => {include: :tasks} } ] )
        return
      else
        response = 'Not login'
        render :json => response.to_json, :status => :unauthorized
        return
      end
    end

    def add_flow
      if current_user

        input = input_params

        flow = Flow.create(:name => 'New Flow' , max_task: 5, max_day: 5, board_id: input[:id])

        render :json => flow.to_json( include:[:tasks , { :flows => {include: :tasks} } ] )

      end
    end

    def add_task
      if current_user

        id = params[:id]
        fid = params[:fid]

        task = Task.create( :state => 'normal',
                            :name => 'new Task',
                            :description => 'new Task',
                            :flow_id => fid)

        render :json => task.to_json

      end
    end

    def get_task
      if current_user
        render :json => Task::find(params[:id]).to_json
      end
    end


    private
    def input_params
      {:id => params.require(:id)}
    end
  end
end