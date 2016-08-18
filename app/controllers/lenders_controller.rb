class LendersController < ApplicationController
  def show
    @lender = Lender.find(params[:id])
    @histories = History.where(lender: @lender).all
  end

  def lend
    me = Lender.find(session[:id])
    borrower = Borrower.find(params[:h][:b_id])
    mymoney = me.money
    braised = borrower.raised
    h_params = params.require(:h).permit(:b_id, :amount)
    lendh = History.create(amount: params[:h][:amount], lender: me, borrower: borrower)
    if lendh.valid?
      braised += params[:h][:amount].to_i
      me.update(money: (mymoney-params[:h][:amount].to_i))
      borrower.update(raised: braised)
      redirect_to "/online_lending/lender/#{session[:id]}"
    else
      flash[:error] = ["Invalid lending, try again"]
      redirect_to "/online_lending/lender/#{session[:id]}"
    end
  end

  def add_balance
    lender = Lender.find(params[:id])
    mymoney = lender.money
    lender.update(money: (mymoney+50))
    redirect_to "/online_lending/lender/#{session[:id]}"
  end
end
