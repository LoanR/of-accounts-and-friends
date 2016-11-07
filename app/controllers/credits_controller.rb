class CreditsController < ApplicationController

  def create
    @new_credit = Credit.new
    current_board = Board.find(params[:board_id])
    @new_credit.board = current_board
    @new_credit.creditor = Friend.find(transaction_params[:creditor])
    @new_credit.debtor = Friend.find(transaction_params[:debtor])
    @new_credit.amountint = transaction_params[:amountint].to_i
    @new_credit.amountdec = transaction_params[:amountdec].to_i
    @new_credit.date = transaction_params[:date]
    @new_credit.comment = transaction_params[:comment]
    # raise
    @new_credit.save
  end

  def destroy
  end

  private

  def transaction_params
    params.require(:credit).permit(:creditor, :debtor, :amountint, :amountdec, :date, :comment)
  end

end
