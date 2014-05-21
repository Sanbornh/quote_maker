class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new

  	if @user.save
  		
  	else
  	end
  end

  def destroy
  end
end
