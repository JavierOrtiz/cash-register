require 'rspec'
require './db/memory'
require './services/cart_service'

describe CartService do
  let(:cart) { [double('Redbull', code: 'RB1', price_in_cents: 250)] }

  before do
    CartService.setup
  end

  describe '.add_item' do
    it 'add an item to the cart' do
      item = 'Apple'
      expect { CartService.add_item(item) }.to change { CartService.list.count }.by(1)
      expect(CartService.list).to include(item)
    end
  end

  describe '.list' do
    it 'list all items from the cart' do
      items = %w[Apple Redbull Jagger]
      items.each { |item| CartService.add_item(item) }
      expect(CartService.list).to match_array(items)
    end
  end

  describe '.remove_item' do
    let(:item) { cart.first }

    it 'removes an item from the cart' do
      CartService.remove_item(item)
      expect(CartService.list).to_not include(item)
    end
  end
end