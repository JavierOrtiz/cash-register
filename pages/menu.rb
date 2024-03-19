require './pages/catalog'
class Menu
  MENU_ITEMS = [
    { name: 'Catalog', klass: Catalog }
  ].freeze

  def self.start
    loop do
      puts "-------- CASH APP MENU --------"
      MENU_ITEMS.each_with_index do |item, i|
        puts "[#{i}] #{item[:name]}"
      end
      puts "----------------------"
      print "Please select an option or Q to exit: "

      chomp = gets.chomp
      close if chomp == 'q'

      option = MENU_ITEMS[chomp.to_i] if chomp =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/

      if option
        option[:klass].start
      else
        item_not_found
      end
    end
  end

  def self.close
    system('clear')
    puts "Bye!"
    exit
  end

  def self.item_not_found
    system('clear')
    puts "Invalid option. Please try again."
  end
end