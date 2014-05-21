class ChangeWallpaperLayoutSchemeColumnName < ActiveRecord::Migration
  def up
  	remove_column :wallpapers, :layout_scheme
  	add_column    :wallpapers, :layout_scheme_id, :integer
  end

  def down
  	remove_column :wallpapers, :layout_scheme_id
  	add_column    :wallpapers, :layout_scheme, :string
  end
end
