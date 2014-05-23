class WallpapersController < ApplicationController

	def new
		@wallpaper = Wallpaper.new
		@colour_schemes = ColourScheme.all
		@layout_schemes = LayoutScheme.all
	end

	def create
		@wallpaper = Wallpaper.new(wallpaper_params)
		if current_user then @wallpaper.user_id = current_user.id end

		if @wallpaper.save
			@wallpaper.create_image
			redirect_to wallpaper_path(@wallpaper.id)
		else
			render :new
		end
	end

	def show
		@wallpaper = Wallpaper.find(params[:id])
	end

	def destroy
		@wallpaper = Wallpaper.find(params[:id])
		@wallpaper.destroy
		redirect_to profile_users_path
	end

	private
	def wallpaper_params
		params.require(:wallpaper).permit(:quote, :colour_scheme_id, :layout_scheme_id)
	end

end
