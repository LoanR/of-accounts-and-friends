class TransactionsController < ApplicationController

  def create
    @new_transaction = Transaction.new
    current_board = Board.find(params[:board_id])
    @new_transaction.board = current_board
    @new_transaction.payer = Friend.find(transaction_params[:payer])
    @new_transaction.amountint = transaction_params[:amountint].to_i
    @new_transaction.amountdec = transaction_params[:amountdec].to_i
    @new_transaction.date = transaction_params[:date]
    @new_transaction.comment = transaction_params[:comment]
    # raise
    @new_transaction.save
  end

  def destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payer, :amountint, :amountdec, :date, :comment)
  end

end
