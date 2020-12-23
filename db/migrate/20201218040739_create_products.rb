class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :buy_price
      t.integer :sell_price
      t.integer :in_stock

      t.timestamps null: false
    end
  end
end
