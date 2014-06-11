class OauthsController < ApplicationController
  skip_before_filter :require_login

  # Makes a request to the desired service
  # and then comes back to callback
  def oauth
  	login_at(auth_params[:provider])
  end

  # If the user exists in the database then they 
  # are logged in. If they are't then a new db entry
  # is created for that user.
  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end

  private
  def auth_params
  	params.permit(:code, :provider)
  end
end
