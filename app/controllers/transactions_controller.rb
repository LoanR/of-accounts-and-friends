class TransactionsController < ApplicationController

  def create
    @new_transaction = Transaction.new
    @current_board = Board.find(params[:board_id])
    @new_transaction.board = @current_board
    @new_transaction.payer = Friend.find(transaction_params[:payer])
    @new_transaction.amountint = transaction_params[:amountint].to_i
    dec = transaction_params[:amountdec] == '' ? 0 : transaction_params[:amountdec]
    @new_transaction.amountdec = (sprintf "%02d", dec).to_i
    @new_transaction.date = transaction_params[:date]
    @new_transaction.comment = transaction_params[:comment]
    # raise
    @new_transaction.save
    @path = board_path(@current_board)
    # raise
    # @new_transaction = Transaction.create!(params[:transaction])
    # @new_transaction = Transaction.create!(
    #   board: Board.find(params[:board_id]),
    #   payer: Friend.find(transaction_params[:payer]),
    #   amountdec: transaction_params[:amountdec].to_i,
    #   amountint: transaction_params[:amountint].to_i,
    #   date: transaction_params[:date],
    #   comment: transaction_params[:comment]
    # )
    # PrivatePub.publish_to(@path, "alert('#{@new_transaction.payer.name}');")
  end

  def destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payer, :amountint, :amountdec, :date, :comment)
  end

end
