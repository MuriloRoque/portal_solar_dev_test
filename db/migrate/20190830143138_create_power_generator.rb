class CreatePowerGenerator < ActiveRecord::Migration[5.2]
  def change
    create_table :power_generators do |t|
      t.string :name
      t.string :description
      t.string :image_url
      t.string :manufacturer
      t.integer :structure_type
      t.float :price
      t.float :height
      t.float :width
      t.float :lenght
      t.float :weight
      t.float :kwp
      t.timestamps
    end
  end
end
