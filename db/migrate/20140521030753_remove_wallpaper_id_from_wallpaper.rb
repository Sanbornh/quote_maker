class RemoveWallpaperIdFromWallpaper < ActiveRecord::Migration
  def change
  	remove_column :wallpapers, :wallpaper_id
  	add_column :wallpapers, :user_id, :integer
  end
end
