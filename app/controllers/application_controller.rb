class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :is_user_logged

  def request_user_logged
  	if session[:userid] == nil
  	  flash[:success] = "You must login to use this feature"
      redirect_to root_path            
  	else
  		return true
  	end
  end
end
