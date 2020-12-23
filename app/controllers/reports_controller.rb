class ReportsController < ApplicationController
    def index
        month = params[:month]
        year = params[:year]
        if (!month || !year) then return end
        orders = Order.where('extract(year  from created_at) = ?', year)
        .where('extract(month  from created_at) = ?', month)
        income = 0
        revenue = 0
        detail = {}
        Product.all.order(:id).each do |p|
            detail[p.id.to_s] = {"name" => p.name, "sold"=> 0, "total_revenue" => 0}
        end
        orders.each do |o|
            items = OrderItem.where('order_id = ?',o.id)
            items.each do |oi|
                quant = oi.quantity
                reve = oi.sell_price - oi.buy_price
                income = income + oi.sell_price * quant
                revenue = revenue + reve * quant
                detail[oi.product_id.to_s]["total_revenue"] = detail[oi.product_id.to_s]["total_revenue"] + reve * quant
                detail[oi.product_id.to_s]["sold"] = detail[oi.product_id.to_s]["sold"] + quant 
            end
        end
        @result = {"income"=> income, "revenue" => revenue, "detail" => detail}
        puts @result
    end
end