require './models/product'
require './pages/menu'
require 'terminal-table'
require './pages/base'

class Catalog < Base
  class << self

    def start
      @products = Product.all
      loop do
        system('clear')
        display_cart_list
        display_main
        chomp = gets.chomp
        close if chomp == 'q'
        handle_action(chomp)
      end
    end

    def close
      system('clear')
      Menu.start
    end

    def display_invalid_option
      system('clear')
      puts "Invalid option. Please try again."
      display_main
    end

    def display_cart_list
      cart_list = CartService.list
      return unless cart_list.any?

      rows = []
      cart_list.each_with_index do |product, i|
        rows << [i, product.name, "#{product.price_in_cents.to_f / 100}€"]
      end

      puts Terminal::Table.new :title => 'CART LIST', :headings => ['#', 'Product', 'Price'], :rows => rows, style: {:width => 60}
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