class WallpapersController < ApplicationController

	def new
		@wallpaper = Wallpaper.new
	end

	def create
		@wallpaper = Wallpaper.new(wallpaper_params)

		if @wallpaper.save
			redirect_to new_wallpaper_path
		else
			render :new
		end
	end

	private
	def wallpaper_params
		params.require(:wallpaper).permit(:quote, :colour_scheme, :layout_scheme)
	end

end
