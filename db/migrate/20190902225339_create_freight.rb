class CreateFreight < ActiveRecord::Migration[5.2]
  def change
    create_table :freights do |t|
      t.string :state
      t.float :weight_min
      t.float :weight_max
      t.float :cost
    end
  end
end
