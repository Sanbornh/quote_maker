class WallpapersController < ApplicationController

	def new
		@wallpaper = Wallpaper.new
		@colour_schemes = ColourScheme.all
	end

	def create
		@wallpaper = Wallpaper.new(wallpaper_params)
		

		if @wallpaper.save
			@wallpaper.create_image
			redirect_to "https://s3-us-west-2.amazonaws.com/quote-maker-storage/wallpaper-#{@wallpaper.id}.jpg"
		else
			render :new
		end
	end

	def preview
		@wallpaper = Wallpaper.find(params[:id])
		@wallpaper.create_image
	end

	private
	def wallpaper_params
		params.require(:wallpaper).permit(:quote, :colour_scheme_id, :layout_scheme)
	end

end
