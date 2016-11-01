class TransactionsController < ApplicationController

  def create
    @new_transaction = Transaction.new
    current_board = Board.find(params[:board_id])
    @new_transaction.board = current_board
    @new_transaction.creditor = transaction_params[:creditor]
    @new_transaction.amount = transaction_params[:amount].to_i
    @new_transaction.date = transaction_params[:date]
    @new_transaction.comment = transaction_params[:comment]
    @new_transaction.save
    if @new_transaction.save
      redirect_to current_board
    else
      redirect_to root_path
    end
  end


  def destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:creditor, :amount, :date, :comment)
  end

end
