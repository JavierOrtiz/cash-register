require 'terminal-table'
require './pages/base'  # require the base class

class Cart < Base
  class << self
    def start
      super
    end

    def display_cart_list
      @cart_list = CartService.list
      rows = []

      @cart_list.each_with_index do |item, i|
        rows << [i, item.name, "#{item.price_in_cents.to_f / 100}€"]
      end

      rows << %w[- - -] if @cart_list.empty?

      rows << :separator
      rows << [nil, "TOTAL AMOUNT:", "#{CartService.total_amount}€"]
      rows << :separator
      rows << [nil, "TOTAL WITH DISCOUNT:", "#{CartService.total_amount_with_discount}€"]
      puts Terminal::Table.new :title => 'CART LIST', :headings => %w[# Product Price], :rows => rows, style: { :width => 60}

      print "Remove product from cart or press Q to go back "
    end

    def display_main
      loop do
        system('clear')
        display_available_offers
        display_cart_list
        chomp = gets.chomp
        close if chomp == 'q'
        handle_action(chomp)
      end
    end

    def display_available_offers
      available_offers = CartService.available_offers
      rows = []
      puts '- 0 offers available' if available_offers.empty?

      return if available_offers.empty?

      available_offers.each_with_index do |offer, i|
        rows << [i, offer.name]
      end

      puts Terminal::Table.new :title => 'OFFERS AVAILABLE', :rows => rows, style: {:width => 60}
    end

    def handle_action(chomp)
      option = @cart_list[chomp.to_i] if chomp =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
      if option
        CartService.remove_item(option)
      else
        display_invalid_option
      end
    end
  end
end