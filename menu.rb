class Menu
  def self.start
    loop do
      puts "-------- CASH APP MENU --------"
      puts "[1] Catalog"
      puts "[2] Cart"
      puts "[3] Checkout"
      puts "[4] Exit"
      puts "----------------------"
      print "Please select an option: "

      option = gets.chomp.to_i

      case option
      when 1
        puts "Catalog service will be called here"
        system('clear')
      when 2
        puts "Cart service will be called here"
        system('clear')
      when 3
        puts "Checkout service will be called here"
        system('clear')
      when 4
        system('clear')
        puts "Bye!"
        break
      else
        system('clear')
        puts "Invalid option. Please try again."
      end
    end
  end
end