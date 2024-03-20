require 'terminal-table'

class Cart
  class << self
    def start
      loop do
        system('clear')
        display_available_offers
        display_main
        chomp = gets.chomp
        close if chomp == 'q'
        handle_action(chomp)
      end
    end
  
    private_class_method
  
    def handle_action(chomp)
      option = @cart_list[chomp.to_i] if chomp =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
      if option
        CartService.remove_item(option)
      else
        display_invalid_option
      end
    end
  
    def display_invalid_option
      system('clear')
      puts "Invalid option. Please try again."
      display_main
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
  
    def close
      system('clear')
      Menu.start
    end
  
    def item_not_found
      system('clear')
      puts "Invalid option. Please try again."
    end
  
    def display_main
      @cart_list = CartService.list
      rows = []

      @cart_list.each_with_index do |item, i|
        rows << [i, item.name, "#{item.price_in_cents.to_f / 100}€"]
      end

      rows << ['-', '-', '-'] if @cart_list.empty?

      rows << :separator
      rows << [nil, "TOTAL AMOUNT:", "#{CartService.total_amount}€"]
      rows << :separator
      rows << [nil, "TOTAL WITH DISCOUNT:", "#{CartService.calculate_total_with_discount}€"]
      puts Terminal::Table.new :title => 'CART LIST', :headings => ['#', 'Product', 'Price'], :rows => rows, style: {:width => 60}

      print "Remove product from cart or press Q to go back "
    end
  end
end