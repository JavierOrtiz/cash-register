require './pages/cart.rb'
require './pages/menu.rb'
require 'rspec'

RSpec.describe Cart do
  context "when the Cart is empty" do
    it "displays an empty cart" do
      expect(CartService).to receive(:list).exactly(3).times.and_return([])
      expect { Cart.display_main }.to output(/\+| -                 | -                    | -             |/).to_stdout
    end
  end

  context "when the Cart has an item" do
    it "displays the cart's contents" do
      cart_list = [double('Product', name: 'Redbull', price_in_cents: 250, code: 'RB1')]
      expect(CartService).to receive(:list).exactly(3).times.and_return(cart_list)
      expect { Cart.display_main }.to output(/Redbull/).to_stdout
    end
  end

  context "when the Cart has multiple item" do
    it "displays the correct total amount" do
      cart_list = [double('Product', name: 'Redbull', price_in_cents: 250, code: 'RB1'), double('Product', name: 'Jagger', price_in_cents: 1150, code: 'JGG1')]
      total_amount = cart_list.sum(&:price_in_cents).to_f / 100
      expect(CartService).to receive(:list).exactly(3).times.and_return(cart_list)
      expect { Cart.display_main }.to output(/TOTAL AMOUNT:        | #{total_amount}€/).to_stdout
    end
  end

  context "when invalid option is selected" do
    it "displays 'Invalid option' message" do
      expect { Cart.item_not_found }.to output(/Invalid option\. Please try again\./).to_stdout
    end
  end

  context "when close is called" do
    it "calls Menu.start" do
      expect(Menu).to receive(:start)
      Cart.close
    end
  end
end