class CreateColourSchemes < ActiveRecord::Migration
  def change
    create_table :colour_schemes do |t|
      t.string :background
      t.string :font
      t.string :highlight

      t.timestamps
    end
  end
end
