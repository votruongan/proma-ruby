class OrdersController < ApplicationController

    def index
        @products = Product.where("is_selling = true").order(id: :asc)
        # @orders.freeze
        @order = Order.new

        @products.each do |product|
            @order.order_items.build(
                product_id: product.id,
                buy_price: product.buy_price,
                sell_price: product.sell_price,
                quantity: 0
            )
        end
    end

    def create
        @order = Order.new(order_params["order"])
        @products = Product.where("is_selling = true").order(id: :asc)
        @order.order_items = @order.order_items.select{ |oi| oi.quantity > 0}
        errorString = "No order has been placed"
        #check if all item quantity is valid -> set price for that item
        if @order.order_items.size > 0
          errorString = nil
          @order.order_items.each do |oi|
            p = @products.find(oi.product_id.to_s)
            oi.quantity = oi.quantity || 0
            if (oi.quantity > p.in_stock)
              errorString = "Cannot order #{p.name} as invalid order quantity"
              break
            end
            oi.buy_price = p.buy_price
            oi.sell_price = p.sell_price
          end
        end

        if errorString then
            respond_to do |format|
                format.html { redirect_to :orders, notice: errorString }
                format.json { render json: :show, status: :unprocessable_entity }
            end
            return
        end
        totalCost = 0
        @order.order_items.each do |ele|
          puts ele.sell_price
          p = @products.find(ele.product_id.to_s)
          p.in_stock = p.in_stock - ele.quantity
          p.save
          totalCost = totalCost + ele.sell_price * ele.quantity
        end
        respond_to do |format|
          if @order.save
            format.html { redirect_to :orders, notice: 'Order placed, total price: ' + totalCost.to_s }
            format.json { render :show, status: :created, location: @order }
          else
            format.html { render :new }
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
        end
    end
    
    private

      def order_params
        eval(params.to_s)
        # params.require(:order).permit(:order_items_attributes)
        # params.require(:order).permit(:order_items, :order_items_attributes, "order_items_attributes")
      end
  
end
