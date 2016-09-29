class BoardsController < ApplicationController
  def index
  end

  def show
    current_board = Board.find_by_id(params[:id])
    if current_board.authorized_user?(current_user)
      @current_board = current_board
    else
      redirect_to root_path
    end
  end

  def create
    @new_board = current_user.boards.new(board_params)
    @new_board.save
    new_account = Account.new
    new_account.user_id = current_user.id
    new_account.board_id = @new_board.id
    new_account.save
    redirect_to board_path(@new_board.id)
  end

  def destroy
  end

  private

  def board_params
    params.require(:board).permit(:title)
  end

end
