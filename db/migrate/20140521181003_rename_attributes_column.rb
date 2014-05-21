class RenameAttributesColumn < ActiveRecord::Migration
	def up
		rename_column :layout_schemes, :attributes, :layout_parameters
	end
end
