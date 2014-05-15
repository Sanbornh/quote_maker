class AddColurSchemeIdToWallpaper < ActiveRecord::Migration
  def up
  	remove_column :wallpapers, :colour_scheme
  	add_column    :wallpapers, :colour_scheme_id, :integer
  end

  def down
  	remove_column :wallpapers, :colour_scheme_id
  	add_column    :wallpapers, :colour_scheme, :string
  end
end
