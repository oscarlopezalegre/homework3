class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create

  	@user = User.new(user_params)

    if(User.find_by_email(@user.email))
      flash[:warning] = "Email in use"
      redirect_to root_path
    else
    	if @user.save
    		#if I could redirect to create a new controller with post I would be so happy
    		#redirect_to url_for(:controller => 'sessions', :action => 'create', :params => user_params, :method => 'post')
    		session[:userid] = @user.id
            flash[:success] = "Welcome to to my homework!"
     	  	#redirect to create
    		redirect_to root_path
    	else
        flash[:warning] = "Password doesn't match"
    		redirect_to root_path	
    	end
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end	
end
