require './models/product'
require './pages/menu'
require './services/cart'

class Catalog
  def self.start
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

  def self.close
    system('clear')
    Menu.start
  end

  def self.display_invalid_option
    system('clear')
    puts "Invalid option. Please try again."
    display_catalog
  end

  def self.display_cart_list
    cart_list = Cart.list
    return unless cart_list.any?

    puts "-------- CART LIST --------"
    cart_list.each_with_index do |item, i|
      puts "[#{i}] #{item.name}"
    end
  end

  def self.display_main
    puts "-------- CATALOG --------"
    @products.each_with_index do |product, i|
      puts "[#{i}] #{product.name}"
    end
    puts "----------------------"
    print "Add product to cart or press Q to go back "
  end

  private_class_method

  def self.handle_action(chomp)
    option = @products[chomp.to_i] if chomp =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
    if option
      Cart.add_item(option)
    else
      display_invalid_option
    end
  end
end