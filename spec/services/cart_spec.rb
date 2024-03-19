require 'rspec'
require './db/memory'
require './services/cart'

describe Cart do
  before do
    Cart.setup
  end

  it 'add an item to the cart' do
    item = 'Apple'
    expect { Cart.add_item(item) }.to change { Cart.list.count }.by(1)
    expect(Cart.list).to include(item)
  end

  it 'list all items from the cart' do
    items = %w[Apple Redbull Jagger]
    items.each { |item| Cart.add_item(item) }
    expect(Cart.list).to match_array(items)
  end
end