class AccountsController < ApplicationController
  def create
    @new_account = Account.new
    current_board = Board.find_by_id(account_params[:board])
    @new_account.board = current_board
    @new_account.user = User.find_by_email(account_params[:user]) || User.find_by_username(account_params[:user])
    @new_account.save
    if @new_account.save
      redirect_to current_board
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private

  def account_params
    params.require(:account).permit(:user, :board)
  end

end
