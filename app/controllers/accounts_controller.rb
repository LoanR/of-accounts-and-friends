class AccountsController < ApplicationController
  def create
    @new_account = Account.new
    @current_board = Board.find(params[:board_id])
    @new_account.board = @current_board
    @new_account.user = User.find_by_email(account_params[:user]) || User.find_by_username(account_params[:user])
    @new_account.save
    @new_friend = Friend.new
    @new_friend.board = @current_board
    @new_friend.name = @new_account.user.username
    @new_friend.save
    @path = board_path(@current_board)
  end

  def destroy
  end

  private

  def account_params
    params.require(:account).permit(:user)
  end

end
