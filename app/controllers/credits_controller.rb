class CreditsController < ApplicationController

  def create
    @new_credit = Credit.new
    @current_board = Board.find(params[:board_id])
    @new_credit.board = @current_board
    @new_credit.creditor = Friend.find(credit_params[:creditor])
    @new_credit.debtor = Friend.find(credit_params[:debtor])
    @new_credit.creator = current_user
    @new_credit.amountint = credit_params[:amountint].to_i
    dec = credit_params[:amountdec] == '' ? 0 : credit_params[:amountdec]
    @new_credit.amountdec = (sprintf "%02d", dec).to_i
    @new_credit.date = credit_params[:date]
    @new_credit.comment = credit_params[:comment]
    # raise
    @new_credit.save
    puts @new_credit
    @path = board_path(@current_board)
  end

  def destroy
  end

  private

  def credit_params
    params.require(:credit).permit(:creditor, :debtor, :amountint, :amountdec, :date, :comment)
  end

end
