class Wallpaper < ActiveRecord::Base

	belongs_to :colour_scheme
	belongs_to :user

	def create_image
		@canvas_width = 2880
		@canvas_height = 1800

		make_canvas
		draw_background
		set_styling
		prep_quote
		establish_coordinates
		composite_image
		save_image
	end

	def make_canvas
		@canvas = Magick::ImageList.new 
	end

	# Note that it's necessary to store color in local
	# variable so that it is scoped correctly when called
	# in block!!
	def draw_background
		color = self.colour_scheme.background	
		image = @canvas.new_image(@canvas_width, @canvas_height) { self.background_color = color }
	end

	def set_styling
		@text = Magick::Draw.new
		@text.font = "#{Rails.root}/lib/fonts/Cardo-Regular.ttf"
		@text.pointsize = 60
		# @text.gravity = Magick::CenterGravity
		@text.align = Magick::LeftAlign
	end

	def prep_quote
		@quote = "“" + self.quote + "”" 
		
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
	def word_wrap(txt, col = 80)
  	txt.gsub(/(.{1,#{col + 4}})(\s+|\Z)/, "\\1\n")
  end

  def establish_coordinates
  	@x = (@canvas_width / 2) - (@quote_width / 2)
  	@y = (@canvas_height / 2) - (@quote_height / 3)
  end

	# Note that it's necessary to store color in local
	# variable so that it is scoped correctly when called
	# in block!!
	def composite_image
		color = self.colour_scheme.font
		@text.annotate(@canvas, 0, 0, @x, @y, @quote) { self.fill = color }
	end

	def save_image
		establish_connection_to_s3

		@canvas.format = 'jpg'
		@bucket.objects["wallpaper-#{self.id}.jpg"].write(@canvas.to_blob)
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
