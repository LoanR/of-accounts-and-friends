class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @boards = current_user.user_boards
    @new_board = Board.new
  end

end
