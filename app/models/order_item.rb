class OrderItem < ActiveRecord::Base
    has_one :order
    
end
