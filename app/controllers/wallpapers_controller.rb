class WallpapersController < ApplicationController

	def new
		@wallpaper = Wallpaper.new
	end

	def create
		@wallpaper = Wallpaper.new(wallpaper_params)

		if @wallpaper.save
			# cookies[:wallpaper_id] = @wallpaper.id
			redirect_to preview_path(@wallpaper.id)
		else
			render :new
		end
	end

	def preview
		@wallpaper = Wallpaper.find(params[:id])
		Wallpaper.create_image(@wallpaper)
	end

	private
	def wallpaper_params
		params.require(:wallpaper).permit(:quote, :colour_scheme, :layout_scheme)
	end

end
