class CreateLayoutSchemes < ActiveRecord::Migration
  def change
    create_table :layout_schemes do |t|
      t.string :font

      t.timestamps
    end
  end
end
