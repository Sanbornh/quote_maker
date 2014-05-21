class ChangeLayoutSchemeColumn < ActiveRecord::Migration
  def up
  	remove_column :layout_schemes, :font
  	add_column    :layout_schemes, :attributes, :hstore
  end

  def down
  	remove_column :layout_schemes, :attributes
  	add_column    :layout_schemes, :font, :string
  end
end
