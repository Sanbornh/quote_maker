class LayoutScheme < ActiveRecord::Base

	has_many :wallpapers
	store_accessor :layout_parameters, :font, :font_size, :quote_marks, :col, :underline, :position
end
