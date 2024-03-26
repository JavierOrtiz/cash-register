require 'terminal-table'

class Base
  class << self
    def start
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

    private_class_method

    def handle_action(chomp)
      raise NotImplementedError, "You must implement the handle_action method"
    end

    def display_main
      raise NotImplementedError, "You must implement display_main"
    end

    def display_cart_list
      raise NotImplementedError, "You must implement display_cart_list"
    end
  end
end