class WallpapersController < ApplicationController

require 'rubygems'
require 'zip'
require 'open-uri'

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

	def download_set
		wallpaper_ids = params[:ids].split(",")
		wallpaper_list = Wallpaper.find(wallpaper_ids)

		@file = Tempfile.new("temp-file-#{current_user.id}")

		Zip::OutputStream.open(@file.path) do |io|
			wallpaper_list.each do |wallpaper|
				io.put_next_entry("wallpaper-#{wallpaper.id}.jpg")
				binding.pry
				io.write open(wallpaper.url).read
			end
		end
		send_file @file.path, type: 'application/zip', disposition: 'attachment', filename: "wallpaper_collection.zip"
	end

	def destroy
		@wallpaper = Wallpaper.find(params[:id])
		@wallpaper.destroy
		redirect_to profile_users_path
	end

	private
	def wallpaper_params
		params.require(:wallpaper).permit(:quote, :colour_scheme_id, :layout_scheme_id, :citation)
	end

end
