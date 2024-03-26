require './models/product'
require './pages/menu'
require 'terminal-table'
require './pages/base'  # require the base class

class Catalog < Base
  class << self
    def start
      @products = Product.all
      super
    end

    def display_cart_list
      cart_list = CartService.list
      return unless cart_list.any?

      rows = []
      cart_list.each_with_index do |product, i|
        rows << [i, product.name, "#{product.price_in_cents.to_f / 100}€"]
      end

      puts Terminal::Table.new :title => 'CART LIST', :headings => %w[# Product Price], :rows => rows, style: { :width => 60}
    end

    def display_main
      rows = []

      @products.each_with_index do |product, i|
        rows << [i, product.name, "#{product.price_in_cents.to_f / 100}€"]
      end

      puts Terminal::Table.new :title => 'CATALOG', :headings => ['#', 'Product', 'Price'], :rows => rows, style: {:width => 60}
      print "Add product to cart or press Q to go back "
    end

    def handle_action(chomp)
      option = @products[chomp.to_i] if chomp =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
      if option
        CartService.add_item(option)
      else
        display_invalid_option
      end
    end
  end
end