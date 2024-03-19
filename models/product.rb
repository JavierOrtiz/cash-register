require './db/seed'

class Product
  attr_accessor :code, :name, :price_in_cents

  def initialize(code, name, price_in_cents)
    @code = code
    @name = name
    @price_in_cents = price_in_cents
    @offers = []
  end

  def self.all
    @all ||= Seed.products.map do |product_hash|
      Product.new(product_hash[:code], product_hash[:name], product_hash[:price_in_cents])
    end
  end
end