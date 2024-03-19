require './pages/cart.rb'
require './pages/menu.rb'
require 'rspec'

RSpec.describe Cart do
  context "when the Cart is empty" do
    it "displays an empty cart" do
      expect(CartService).to receive(:list).and_return([])
      expect { Cart.display_main }.to output(/Empty cart/).to_stdout
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