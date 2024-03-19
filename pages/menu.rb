require './pages/catalog'
class Menu
  MENU_ITEMS = [
    { name: 'Catalog', klass: Catalog }
  ].freeze

  def self.start
    loop do
      system('clear')
      display_main
      chomp = gets.chomp
      close if chomp == 'q'
      handle_action(chomp)
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

  def self.display_main
    puts "-------- CASH APP MENU --------"
    MENU_ITEMS.each_with_index do |item, i|
      puts "[#{i}] #{item[:name]}"
    end
    puts "----------------------"
    print "Please select an option or Q to exit: "
  end

  private_class_method

  def self.handle_action(chomp)
    option = MENU_ITEMS[chomp.to_i] if chomp =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/

    if option
      option[:klass].start
    else
      item_not_found
    end
  end
end