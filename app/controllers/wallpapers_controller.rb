class WallpapersController < ApplicationController

	def new
		@wallpaper = Wallpaper.new
		@colour_schemes = ColourScheme.all
	end

	def create
		@wallpaper = Wallpaper.new(wallpaper_params)
		@wallpaper.create_image

		if @wallpaper.save
			# redirect_to preview_path(@wallpaper.id)
			redirect_to "https://s3-us-west-2.amazonaws.com/quote-maker-storage/wallpaper.jpg"
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
