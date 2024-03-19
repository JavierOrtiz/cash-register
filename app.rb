require './pages/menu'
require './services/cart'

class App
  def initialize
    system('clear')
    Cart.setup
    Menu.start
  end
end

App.new
