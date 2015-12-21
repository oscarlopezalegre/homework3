class SessionsController < ApplicationController

  def new
    redirect_to root_path
  end


  def create


  	@email = params[:session][:email]
  	@password = params[:session][:password]
	  @success= false
	  user = User.find_by_email(@email)


  	if user

  		if user.authenticate(@password)
  			#authorization completed
  			session[:userid] = user.id
  			#good you authenticated
  			redirect_to root_path
  		else
  			#authorization failed
        flash[:warning] = "Wrong email/password combination"  
        redirect_to root_path
  		end
  	else
  		#email not found
      flash[:warning] = "Email doesn't exist"  
      redirect_to root_path

  	end
  end

  def destroy
  	session.delete(:userid)
  	redirect_to root_path
  end

  #needed for the log in with facebook
  def fb_create    
    user = User.from_omniauth(env["omniauth.auth"])
    session[:userid] = user.id
    redirect_to messages_path
  end

  def fb_destroy
    session[:userid] = nil
    redirect_to root_path
  end

end
