class LayoutScheme < ActiveRecord::Base

	has_many :wallpapers

	store_accessor :layout_parameters, :font
	store_accessor :layout_parameters, :font_size
	store_accessor :layout_parameters, :quote_marks
	
end
