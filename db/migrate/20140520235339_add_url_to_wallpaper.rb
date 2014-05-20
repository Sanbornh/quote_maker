class AddUrlToWallpaper < ActiveRecord::Migration
  def change
    add_column :wallpapers, :url, :string
  end
end
