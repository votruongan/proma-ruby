json.extract! product, :id, :name, :buy_price, :sell_price, :in_stock, :created_at, :updated_at
json.url product_url(product, format: :json)
