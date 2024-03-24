require './db/memory'
require './models/product_offer'
require './models/offer'
require './services/calculator_service'

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
      calculator.calculate
    end

    def total_amount_with_discount
      calculator.calculate(with_discount: true)
    end

    private

    def calculator
      @calculator ||= CalculatorService.new(list)
    end
  end
end
