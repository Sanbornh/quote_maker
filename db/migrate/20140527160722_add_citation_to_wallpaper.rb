class AddCitationToWallpaper < ActiveRecord::Migration
  def change
    add_column :wallpapers, :citation, :string
  end
end
