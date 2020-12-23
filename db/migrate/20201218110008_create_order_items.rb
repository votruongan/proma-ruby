class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :user_id
      t.integer :buy_price
      t.integer :sell_price
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
