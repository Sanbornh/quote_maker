class CreateWallpapers < ActiveRecord::Migration
  def change
    create_table :wallpapers do |t|
      t.text :quote
      t.string :colour_scheme
      t.string :layout_scheme

      t.timestamps
    end
  end
end
