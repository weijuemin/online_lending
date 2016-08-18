class MainController < ApplicationController
  def new
  end

  def create_lender
    l = Lender.create(lender_params)
    if l.valid?
      session[:id] = l.id
      session[:role] = 'lender'
      redirect_to "/online_lending/login"
    else
      session.clear
      flash[:error] = l.errors.full_messages
      redirect_to "/online_lending/register"
    end
  end

  def create_borrower
    b = Borrower.create(borrower_params)
    if b.valid?
      session[:id] = b.id
      session[:role] = 'borrower'
      redirect_to "/online_lending/login"
    else
      session.clear
      flash[:error] = b.errors.full_messages
      redirect_to "/online_lending/register"
    end
  end

  def login
  end

  def login_lender
    lender = Lender.find_by(email: params[:user][:email])
    if lender
      if lender.authenticate(params[:user][:password])
        session[:id] = lender.id
        session[:role] = 'lender'
        redirect_to "/online_lending/lender/#{lender.id}"
      else
        flash[:error] = ["Incorrect password!"]
        redirect_to :action => "login"
      end
    else
      flash[:error] = ["Lender not found..."]
      redirect_to :action => "login"
    end
  end

  def login_borrower
    borrower = Borrower.find_by(email: params[:user][:email])
    if borrower
      if borrower.authenticate(params[:user][:password])
        session[:id] = borrower.id
        session[:role] = 'borrower'
        redirect_to "/online_lending/borrower/#{borrower.id}"
      else
        flash[:error] = ["Incorrect password!"]
        redirect_to :action => "login"
      end
    else
      flash[:error] = ["Borrower not found..."]
      redirect_to :action => "login"
    end
  end

  def logout
    session.clear
    redirect_to :action => "new"
  end

  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
  end

  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :money, :purpose, :description, :raised)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
