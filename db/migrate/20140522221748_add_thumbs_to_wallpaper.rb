class AddThumbsToWallpaper < ActiveRecord::Migration
  def change
    add_column :wallpapers, :thumb, :string
  end
end
