require './pages/catalog'
require './pages/cart'
require './pages/base'

class Menu < Base
  class << self

    MENU_ITEMS = [
      { name: 'Catalog', klass: Catalog },
      { name: 'Cart', klass: Cart },
    ].freeze

    def start
      loop do
        system('clear')
        display_main
        chomp = gets.chomp
        close if chomp == 'q'
        handle_action(chomp)
      end
    end

    def close
      system('clear')
      puts "Bye!"
      exit
    end

    def item_not_found
      system('clear')
      puts "Invalid option. Please try again."
    end

    def display_main
      puts "-------- CASH APP MENU --------"
      MENU_ITEMS.each_with_index do |item, i|
        puts "[#{i}] #{item[:name]}"
      end
      puts "----------------------"
      print "Please select an option or Q to exit: "
    end

    def handle_action(chomp)
      option = MENU_ITEMS[chomp.to_i] if chomp =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/

      if option
        option[:klass].start
      else
        item_not_found
      end
    end
  end
end