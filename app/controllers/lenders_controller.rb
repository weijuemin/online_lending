class LendersController < ApplicationController
  before_action :require_login
  def show
    if correct_url
      @lender = Lender.find(session[:id])
      @histories = History.where(lender: @lender).all
    else
      flash[:error] = ["Please not try to browse other people's data. If you have another role, please log in first."]
      redirect_to "/online_lending/#{session[:role]}/#{session[:id]}"
    end
  end

  def lend
    me = Lender.find(session[:id])
    borrower = Borrower.find(params[:h][:b_id])
    mymoney = me.money
    braised = borrower.raised
    thisAmt = params[:h][:amount].to_i

    if thisAmt > mymoney
      flash[:error] = ["Not enough balance"]
    else
      h_params = params.require(:h).permit(:b_id, :amount)
      h = History.find_by(lender: me, borrower: borrower)
      if h
        h_oldAmt = h.amount
        h.update amount: (h_oldAmt+thisAmt)
        borrower.update raised: (braised+thisAmt)
        me.update money: (mymoney-thisAmt)
      else
        lendh = History.create(amount: thisAmt, lender: me, borrower: borrower)
        if lendh.valid?
          braised += thisAmt
          me.update(money: (mymoney-thisAmt))
          borrower.update(raised: braised)
        else
          flash[:error] = ["Please enter amount"]
        end
      end
    end
    redirect_to "/online_lending/lender/#{session[:id]}"
  end

  def add_balance
    if correct_url
      lender = Lender.find(session[:id])
      mymoney = lender.money
      lender.update(money: (mymoney+50))
      redirect_to "/online_lending/lender/#{session[:id]}"
    else
      flash[:error] = ["Can't update other people's balance"]
      redirect_to :action=>"show", :id=>session[:id]
    end
  end
end
