class UsersController < ApplicationController
  before_filter :require_login, only: [:profile]
  def new
  	@user = User.new
  end

  def profile
  	@user = current_user
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		redirect_to root_url, :notice=>"Signed Up!"
  	else
  		render :new
  	end
  end

 
  private
  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
