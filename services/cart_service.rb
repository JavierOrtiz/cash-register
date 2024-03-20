require './db/memory'
require './models/product_offer'
require './models/offer'
require 'pry'

class CartService
  class << self
    CART_KEY = 'cart'.freeze
  
    def setup
      Memory.add(CART_KEY, [])
    end
  
    def list
      Memory.get(CART_KEY)
    end
  
    def add_item(item)
      Memory.add(CART_KEY, Memory.get(CART_KEY) << item)
    end
  
    def remove_item(item)
      cart = Memory.get(CART_KEY)
      index = cart.index { |cart_item| cart_item == item }
      cart.delete_at(index) unless index.nil?
      Memory.add(CART_KEY, cart)
    end
  
    def available_offers
      product_codes = list.map(&:code).uniq
      matches = ProductOffer.all.select { |product_offer| product_codes.include?(product_offer.product_code) }
      Offer.all.select { |offer| matches.map(&:offer_slug).uniq.include?(offer.slug) }
    end
  
    def total_amount
      list.sum(&:price_in_cents).to_f / 100
    end
  
    def calculate_total_with_discount # TODO: Refactor and split this code, and test it
      cart = list
      total = 0
  
      product_codes = list.map(&:code).uniq
      product_offers = ProductOffer.all.select { |product_offer| product_codes.include?(product_offer.product_code) }
      product_offers.each do |p_offer|
        total_matched_products = cart.count { |product| product.code == p_offer.product_code }
        product = Product.all.find { |o| o.code == p_offer.product_code }
        offer = Offer.all.find { |o| o.slug == p_offer.offer_slug }
        if offer.logic.include?('current_quantity')
          eval_offer_logic = offer.logic.gsub('current_quantity', total_matched_products.to_s)
        end
        if offer.logic.include?('original_unit_price')
          eval_offer_logic = (eval_offer_logic || offer.logic).gsub('original_unit_price', product.price_in_cents.to_s)
        end
        if offer.logic.include?('new_unit_price')
          if p_offer.new_unit_price.to_s.include?('price')
            eval_offer_logic = (eval_offer_logic || offer.logic).gsub('new_unit_price', "(#{p_offer.new_unit_price.gsub('price', product.price_in_cents.to_s)})")
          else
            eval_offer_logic = (eval_offer_logic || offer.logic).gsub('new_unit_price', p_offer.new_unit_price.to_s)
          end
        end
        if offer.logic.include?('min_quantity')
          eval_offer_logic = (eval_offer_logic || offer.logic).gsub('min_quantity', p_offer.min_quantity.to_s)
        end
        total += eval(eval_offer_logic)
      end
      (total.to_f / 100).round(2)
    end
  end
end
