class Wallpaper < ActiveRecord::Base

	belongs_to :colour_scheme

	def self.create_image(wallpaper)
		# @wallpaper = wallpaper
		color = wallpaper.colour_scheme
		quote = wallpaper.quote
		# binding.pry

		make_canvas
		draw_background(color)  #Here we can pass in dimensions eventually
		styling = set_styling
		composite_image(styling, quote)
		save_image
	end

	def self.make_canvas
		@@canvas = Magick::ImageList.new
	end

	def self.draw_background(color)
		@@canvas.new_image(2880, 1800) { self.background_color = color }
	end

	def self.set_styling
		text = Magick::Draw.new
		text.font = "#{Rails.root}/lib/fonts/Cardo-Regular.ttf"
		text.pointsize = 150
		text.gravity = Magick::CenterGravity

		text
	end

	def self.composite_image(styling, quote)
		styling.annotate(@@canvas, 0, 0, 0, 0, quote) { self.fill = 'white'}
	end

	def self.save_image
		@@canvas.write('testingRmagickRails.jpg')
	end
end
