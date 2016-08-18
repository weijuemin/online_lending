Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/online_lending/register" => "main#new"

  post "/online_lending/lender" => "main#create_lender"

  post "/online_lending/borrower" => "main#create_borrower"

  get "/online_lending/login" => "main#login"

  post "/online_lending/lender/login" => "main#login_lender"

  post "/online_lending/borrower/login" => "main#login_borrower"

  get "/users/logout" => "main#logout"
  
  # Lenders
  get "/online_lending/lender/:id" => "lenders#show"

  patch "/lend" => "lenders#lend"

  patch "/add_balance/:id" => "lenders#add_balance"
  
  # Borrowers
  get "/online_lending/borrower/:id" => "borrowers#show"
end
