class AddIsSellingToProduct < ActiveRecord::Migration
  def change
    add_column :products, :is_selling, :boolean
  end
end
