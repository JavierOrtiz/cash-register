require './db/memory'

class CartService
  CART_KEY = 'cart'.freeze

  def self.setup
    Memory.add(CART_KEY, [])
  end

  def self.list
    Memory.get(CART_KEY)
  end

  def self.add_item(item)
    Memory.add(CART_KEY, Memory.get(CART_KEY) << item)
  end
end
