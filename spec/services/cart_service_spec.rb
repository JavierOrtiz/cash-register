require 'rspec'
require './db/memory'
require './services/cart_service'

describe CartService do
  before do
    CartService.setup
  end

  it 'add an item to the cart' do
    item = 'Apple'
    expect { CartService.add_item(item) }.to change { CartService.list.count }.by(1)
    expect(CartService.list).to include(item)
  end

  it 'list all items from the cart' do
    items = %w[Apple Redbull Jagger]
    items.each { |item| CartService.add_item(item) }
    expect(CartService.list).to match_array(items)
  end
end