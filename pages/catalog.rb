require './models/product'
require './pages/menu'

class Catalog
  def self.start
    products = Product.all
    loop do
      system('clear')
      puts "-------- CATALOG --------"
      products.each_with_index do |product, i|
        puts "[#{i}] #{product.name}"
      end
      puts "----------------------"
      print "Add product to cart or press Q to go back "

      chomp = gets.chomp
      close if chomp == 'q'
      option = products[chomp.to_i] if chomp =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/

      if option
        puts option.name
      else
        item_not_found
      end
    end
  end

  def self.close
    system('clear')
    Menu.start
  end

  def self.item_not_found
    system('clear')
    puts "Invalid option. Please try again."
  end
end