class BoardsController < ApplicationController
  before_action :find_board, only: [:show]

  def index
  end

  def show
    @new_account = Account.new
    @new_friend = Friend.new
    @new_transaction = Transaction.new
    @new_credit = Credit.new
    @path = board_path(@current_board)
  end

  def create
    @new_board = current_user.boards.new(board_params)
    @new_board.save
    new_account = Account.new
    new_account.user_id = current_user.id
    new_account.board_id = @new_board.id
    new_account.save
    new_friend = Friend.new
    new_friend.name = current_user.username
    new_friend.board = @new_board
    new_friend.save
    redirect_to board_path(@new_board.id)
  end

  def destroy
  end

  private

  def board_params
    params.require(:board).permit(:title)
  end

  def find_board
    current_board = Board.find(params[:id])
    if current_board.authorized_user?(current_user)
      @current_board = current_board
    else
      redirect_to root_path
    end
  end

end
