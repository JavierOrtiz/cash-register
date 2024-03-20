require './db/memory'
require './models/product_offer'
require './models/offer'

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
  
    def calculate_total_with_discount
      total = 0

      product_offers.each do |p_offer|
        total += apply_discounts(p_offer)
      end

      (total.to_f / 100).round(2)
    end

    private

    def product_offers
      product_codes = list.map(&:code).uniq
      ProductOffer.all.select { |product_offer| product_codes.include?(product_offer.product_code) }
    end

    def product(p_offer)
      Product.all.find { |o| o.code == p_offer.product_code }
    end

    def offer(p_offer)
      Offer.all.find { |o| o.slug == p_offer.offer_slug }
    end

    def apply_discounts(p_offer)
      eval_offer_logic = calculate_logic(p_offer)
      eval(eval_offer_logic)
    end

    def calculate_logic(p_offer)
      offer_logic = offer(p_offer).logic.dup
      total_matched_products = list.count { |product| product.code == p_offer.product_code }

      {
        'current_quantity' => total_matched_products.to_s,
        'original_unit_price' => product(p_offer).price_in_cents.to_s,
        'new_unit_price' => calculate_new_unit_price(p_offer),
        'min_quantity' => p_offer.min_quantity.to_s
      }.each do |key, value|
        offer_logic.gsub!(key, value) if offer_logic.include?(key)
      end

      offer_logic
    end

    def calculate_new_unit_price(p_offer)
      p_offer.new_unit_price.to_s.include?('price') ?
        "(#{p_offer.new_unit_price.gsub('price', product(p_offer).price_in_cents.to_s)})" :
        p_offer.new_unit_price.to_s
    end
  end
end
