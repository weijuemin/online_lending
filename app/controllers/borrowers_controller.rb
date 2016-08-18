class BorrowersController < ApplicationController
  before_action :require_login
  def show
    if correct_url
      @borrower = Borrower.find(session[:id])
      @histories = History.where(borrower: @borrower).all
    else
      flash[:error] = ["Please not try to browse other people's data. If you have another role, please log in first."]
      redirect_to "/online_lending/#{session[:role]}/#{session[:id]}"
    end
  end
end
