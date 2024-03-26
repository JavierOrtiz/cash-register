require './services/cart_service.rb'
require './pages/cart.rb'
require './pages/menu.rb'
require 'rspec'

RSpec.describe Cart do
  context "when the Cart is empty" do
    it "displays an empty cart" do
      expect(CartService).to receive(:list).exactly(2).times.and_return([])
      expect { Cart.display_main }.to output(/\+| -                 | -                    | -             |/).to_stdout
    end
  end

  context "when the Cart has an item" do
    it "displays the cart's contents" do
      cart_list = [double('Product', name: 'Redbull', price_in_cents: 250, code: 'RB1')]
      expect(CartService).to receive(:list).and_return(cart_list)
      expect { Cart.display_main }.to output(/Redbull/).to_stdout
    end
  end

  context "when the Cart has multiple item" do
    it "displays the correct total amount" do
      cart_list = [double('Product', name: 'Redbull', price_in_cents: 250, code: 'RB1'), double('Product', name: 'Jagger', price_in_cents: 1150, code: 'JGG1')]
      total_amount = cart_list.sum(&:price_in_cents).to_f / 100
      expect(CartService).to receive(:list).and_return(cart_list)
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

  context "when handle_action is called with an invalid option" do
    it "display_invalid_option is called" do
      expect(Cart).to receive(:display_invalid_option)
      Cart.handle_action('test')
    end
  end

  context "when handle_action is called with a valid option" do
    it "calls the CartService.remove_item method" do
      allow(Cart).to receive(:display_invalid_option) # Stub this to prevent its execution
      expect(CartService).to receive(:remove_item).with(1)
      Cart.instance_variable_set(:@cart_list, [0,1,2,3])
      Cart.handle_action('1')
    end
  end

  context "when display_available_offers is called" do
    it "calls the necessary methods" do
      available_offers = [double('Offer', name: 'offer name')]
      expect(CartService).to receive(:available_offers).and_return(available_offers)
      expect { Cart.display_available_offers }.to output(/OFFERS AVAILABLE/).to_stdout
    end
  end
end