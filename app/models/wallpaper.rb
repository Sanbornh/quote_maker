class Wallpaper < ActiveRecord::Base

	belongs_to :colour_scheme

	def create_image
		make_canvas
		draw_background
		set_styling
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
		image = @canvas.new_image(2880, 1800) { self.background_color = color }
	end

	def set_styling
		@text = Magick::Draw.new
		@text.font = "#{Rails.root}/lib/fonts/Cardo-Regular.ttf"
		@text.pointsize = 150
		@text.gravity = Magick::CenterGravity
	end

	# Note that it's necessary to store color in local
	# variable so that it is scoped correctly when called
	# in block!!
	def composite_image
		color = self.colour_scheme.font
		@text.annotate(@canvas, 0, 0, 0, 0, self.quote) { self.fill = color }
	end

	def save_image
		AWS.config(access_key_id: S3_CREDENTIALS["access_key_id"], secret_access_key: S3_CREDENTIALS["secret_access_key"], region: 'us-west-2')
		s3 = AWS::S3.new
		bucket = s3.buckets[S3_CREDENTIALS["bucket"]]


		@canvas.format = 'jpg'
		blob = @canvas.to_blob
		
		obj = bucket.objects["wallpaper.jpg"].write(blob)

		# binding.pry
		# @canvas.write('testingRmagickRails.jpg')
	end
end
