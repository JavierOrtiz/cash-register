class Cart
  def self.start
    loop do
      system('clear')
      display_available_offers
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

  def self.item_not_found
    system('clear')
    puts "Invalid option. Please try again."
  end

  def self.display_main
    cart_list = CartService.list

    puts "-------- CART LIST --------"
    puts '- Empty cart' if cart_list.empty?

    cart_list.each_with_index do |item, i|
      puts "[#{i}] - #{item.name} - #{item.price_in_cents.to_f / 100}€"
    end
    puts "----------------------"

    puts "TOTAL AMOUNT: #{cart_list.sum(&:price_in_cents).to_f / 100}€"

    puts "----------------------"
    print "Add product to cart or press Q to go back "
  end

  def self.display_available_offers
    available_offers = CartService.available_offers
    puts "-------- OFFERS AVAILABLE --------"
    puts '- 0 offers available' if available_offers.empty?

    available_offers.each_with_index do |offer, i|
      puts "[#{i}] - #{offer.name}"
    end
  end
end