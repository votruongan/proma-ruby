class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :product_id
      t.integer :add_stock

      t.timestamps null: false
    end
  end
end
