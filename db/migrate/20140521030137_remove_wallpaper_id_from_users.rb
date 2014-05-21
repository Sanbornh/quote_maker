class RemoveWallpaperIdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :wallpaper_id
  	add_column :wallpapers, :user_id, :integer
  end
end
