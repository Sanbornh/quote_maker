class Wallpaper < ActiveRecord::Base

	belongs_to :colour_scheme
	belongs_to :user
	belongs_to :layout_scheme

	def create_image
		init_variables
		draw_background
		set_styling
		prep_quote
		establish_coordinates
		composite_image
		save_image
	end

	def init_variables
		@canvas = Magick::ImageList.new 
		@canvas_width = 2880
		@canvas_height = 1800
		@quote = self.quote
	end

	# Note that it's necessary to store the background 
	# color in a local variable and NOT an instance variable
	# so that it is scoped correctly when called in block!!
	def draw_background
		color = self.colour_scheme.background	
		@canvas.new_image(@canvas_width, @canvas_height) { self.background_color = color }
	end

	def set_styling
		@text = Magick::Draw.new
		@text.font = "#{Rails.root}/lib/fonts/#{self.layout_scheme.font}.ttf"
		@text.pointsize = self.layout_scheme.font_size.to_i
		@text.align = Magick::LeftAlign
	end

	def prep_quote
		if self.layout_scheme.quote_marks then @quote << "”" end
		wrap_quote
		get_quote_dimensions
	end

	def wrap_quote
		word_count = @quote.split.count

		if word_count <= 11
			@quote
		else
			@quote = word_wrap(@quote, 50)
		end	
	end

	def get_quote_dimensions
		metrics = @text.get_multiline_type_metrics(@canvas, @quote)
		@quote_width = metrics[:width]
		@quote_height = metrics[:height]
	end

	# Sourced from github/cmdrkeene/memegen
	def word_wrap(txt, col = 50)
  	txt.gsub(/(.{1,#{col + 4}})(\s+|\Z)/, "\\1\n")
  end

  def establish_coordinates
  	@x = (@canvas_width / 2) - (@quote_width / 2)
  	@y = (@canvas_height / 2) - (@quote_height / 3)
  end

	# Note that it's necessary to store the background 
	# color in a local variable and NOT an instance variable
	# so that it is scoped correctly when called in block!!
	def composite_image
		color = self.colour_scheme.font
		@text.annotate(@canvas, 0, 0, @x, @y, @quote) { self.fill = color }

		if self.layout_scheme.quote_marks
			@text.annotate(@canvas, 0, 0, (@x - 28), @y, "“") {self.fill = color }
		end
	end

	def save_image
		establish_connection_to_s3

		@canvas.format = 'jpg'
		@bucket.objects["wallpaper-#{self.id}.jpg"].write(@canvas.to_blob)
		self.url = "https://s3-us-west-2.amazonaws.com/quote-maker-storage/wallpaper-#{self.id}.jpg"
	end

	def establish_connection_to_s3
		@s3 = AWS::S3.new(
		  access_key_id:     S3_CREDENTIALS["access_key_id"],
		  secret_access_key: S3_CREDENTIALS["secret_access_key"],
		  region: "us-west-2"
		)
		@bucket = @s3.buckets[S3_CREDENTIALS["bucket"]]
	end
end
