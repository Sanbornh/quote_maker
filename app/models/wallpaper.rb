class Wallpaper < ActiveRecord::Base

	belongs_to :colour_scheme
	belongs_to :user
	belongs_to :layout_scheme

	def create_image
		init_variables
		draw_background
		set_quote_styling
		prep_quote
		establish_coordinates
		set_citation_styling
		draw_lines
		composite_image
		save_image
		generate_thumb
	end

	# Note that anything coming in from layout_scheme is 
	# coming in as a string because LayoutScheme stores it
	# in an hstore. If you are expecting integers, you must explicitly
	# convert them and THERE ARE NO BOOLEAN VALUES. 
	def init_variables
		@canvas = Magick::ImageList.new 
		@canvas_width = 2880
		@canvas_height = 1800
		@quote = self.quote
		@citation = self.citation
		@highlight = self.colour_scheme.highlight
		@quote_marks = self.layout_scheme.quote_marks 
		@font_size = self.layout_scheme.font_size.to_i
		@col = self.layout_scheme.col.to_i
		@position = self.layout_scheme.position
		@underline = self.layout_scheme.underline
	end

	# Note that it's necessary to store the background 
	# color in a local variable and NOT an instance variable
	# so that it is scoped correctly when called in block!!
	def draw_background
		color = self.colour_scheme.background	
		@canvas.new_image(@canvas_width, @canvas_height) { self.background_color = color }
	end

	def set_quote_styling
		@text = Magick::Draw.new
		@text.font = "#{Rails.root}/lib/fonts/#{self.layout_scheme.font}.ttf"
		@text.pointsize = @font_size
		@text.align = Magick::LeftAlign
	end

	def set_citation_styling
		@citation_params = Magick::Draw.new
		@citation_params.font = "#{Rails.root}/lib/fonts/#{self.layout_scheme.font}.ttf"
		@citation_params.pointsize = @font_size
		@citation_params.align = Magick::LeftAlign
	end

	def prep_quote
		if @quote_marks then @quote << "”" end
		wrap_quote
		get_quote_dimensions
	end

	def wrap_quote
		word_count = @quote.split.count

		if word_count <= 11
			@quote
		else
			@quote = word_wrap(@quote, @col)
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
  	if @position == "bottom-left"
  		@x = 300
  		@y = 1700 - @quote_height
	  else
	  	@x = (@canvas_width / 2) - (@quote_width / 2)
	  	@y = (@canvas_height / 2) - (@quote_height / 3)
	  end
  end

  def draw_lines
  	if @underline
  		@line = Magick::Draw::new
  		@line.rectangle(300,1500,2400,1510)
  		@line.fill = @highlight
  		@line.draw(@canvas)

  		@line = Magick::Draw::new
  		@line.rectangle(300,1530,2400,1550)
  		@line.fill = self.colour_scheme.font
  		@line.draw(@canvas)
  	end
  end

	# Note that it's necessary to store the background 
	# color in a local variable and NOT an instance variable
	# so that it is scoped correctly when called in block!!
	def composite_image
		color = self.colour_scheme.font
		highlight_color = self.colour_scheme.highlight
		@text.annotate(@canvas, 0, 0, @x, @y, @quote) { self.fill = color }

		if @quote_marks
			@text.annotate(@canvas, 0, 0, (@x - 28), @y, "“") {self.fill = color }
		end

		@citation_params.annotate(@canvas, 0, 0, @x , @y + @quote_height, @citation) {self.fill = highlight_color}
	end

	def save_image
		establish_connection_to_s3

		@canvas.format = 'jpg'
		@bucket.objects["wallpaper-#{self.id}.jpg"].write(@canvas.to_blob)
		self.update_attribute(:url, "https://s3-us-west-2.amazonaws.com/quote-maker-storage/wallpaper-#{self.id}.jpg")
	end

	def establish_connection_to_s3
		@s3 = AWS::S3.new(
		  access_key_id:     S3_CREDENTIALS["access_key_id"],
		  secret_access_key: S3_CREDENTIALS["secret_access_key"],
		  region: "us-west-2"
		)
		@bucket = @s3.buckets[S3_CREDENTIALS["bucket"]]
	end

	def generate_thumb
		@bucket.objects["thumb-#{self.id}.jpg"].write(@canvas.scale(300, 187).to_blob)
		self.update_attribute(:thumb, "https://s3-us-west-2.amazonaws.com/quote-maker-storage/thumb-#{self.id}.jpg")
	end
end
