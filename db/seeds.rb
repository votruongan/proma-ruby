5.times do |i|
    Product.create(name: "Product #{i}", description: "A product.", 
        buy_price:rand(100), sell_price: rand(100), in_stock: rand(50), 
        is_selling: true)
  end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  