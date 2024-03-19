require './db/seed'

class ProductOffer
  attr_accessor :offer_slug, :product_code, :min_quantity, :new_unit_price

  def initialize(offer_slug, product_code, min_quantity, new_unit_price)
    @offer_slug = offer_slug
    @product_code = product_code
    @min_quantity = min_quantity
    @new_unit_price = new_unit_price
  end

  def self.all
    @all ||= Seed.product_offers.map do |product_offer_hash|
      ProductOffer.new(product_offer_hash[:offer_slug], product_offer_hash[:product_code], product_offer_hash[:min_quantity], product_offer_hash[:new_unit_price])
    end
  end
end