class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def require_login
    redirect_to "/online_lending/login" if session[:id] == nil
  end

  def correct_url
    require "uri"
    uri = URI(request.original_url)
    role = uri.path.split("/")[-2]
    if (session[:id] == params[:id].to_i) and (role == session[:role])
      return true
    else
      return false
    end
  end
end
