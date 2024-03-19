require './db/memory'
require './models/product_offer'
require './models/offer'

class CartService
  CART_KEY = 'cart'.freeze

  def self.setup
    Memory.add(CART_KEY, [])
  end

  def self.list
    Memory.get(CART_KEY)
  end

  def self.add_item(item)
    Memory.add(CART_KEY, Memory.get(CART_KEY) << item)
  end

  def self.available_offers
    product_codes = list.map(&:code).uniq
    matches = ProductOffer.all.select { |product_offer| product_codes.include?(product_offer.product_code) }
    Offer.all.select { |offer| matches.map(&:offer_slug).uniq.include?(offer.slug) }
  end
end
