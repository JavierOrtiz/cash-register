require './db/memory'
require './models/product_offer'
require './models/offer'
require 'pry'

class CalculatorService
  attr_reader :products
  def initialize(products)
    @products = products
  end

  def calculate(with_discount: false)
    with_discount ? calculate_total_with_discount : total_amount
  end

  private

  def total_amount
    products.sum(&:price_in_cents).to_f / 100
  end

  def calculate_total_with_discount
    total = 0

    product_offers.each do |p_offer|
      total += apply_discounts(p_offer)
    end

    (total.to_f / 100).round(2)
  end

  def product_offers
    product_codes = products.map(&:code).uniq
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
    total_matched_products = products.count { |product| product.code == p_offer.product_code }

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
