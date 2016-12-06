class FriendsController < ApplicationController
  def create
    @new_friend = Friend.new
    @current_board = Board.find(params[:board_id])
    @new_friend.board = @current_board
    @new_friend.name = friend_params[:name]
    @new_friend.save
    @path = board_path(@current_board)
    # if @new_friend.save
    #   redirect_to current_board
    # else
    #   redirect_to root_path
    # end
  end

  def destroy
  end

  private

  def friend_params
    params.require(:friend).permit(:name)
  end
end
