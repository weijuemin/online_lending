class BorrowersController < ApplicationController
  def show
    @borrower = Borrower.find(params[:id])
    @histories = History.where(borrower: @borrower).all
  end

end
