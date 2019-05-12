require "pry"

def consolidate_cart(cart)
  cart.each_with_object({}) do |item, consolidated_cart|
    item.each do |product, attributes|
      if !consolidated_cart.include?(product)
        consolidated_cart[product] = attributes
        consolidated_cart[product][:count] = 1
      else
        consolidated_cart[product][:count] += 1
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
      if cart.include?("#{coupon[:item]} W/COUPON".upcase) && cart[coupon[:item]][:count] >= coupon[:num]
        cart[coupon[:item]][:count] -= coupon[:num]
        cart["#{coupon[:item]} W/COUPON".upcase][:count] += 1
      elsif cart.include?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
        cart[coupon[:item]][:count] -= coupon[:num]
        cart["#{coupon[:item]} W/COUPON".upcase] = {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => 1}
      end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.map do |product, attributes|
    if attributes[:clearance] == true
      attributes[:price] = (attributes[:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)


end
