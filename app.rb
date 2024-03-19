require './pages/menu'
require './services/cart_service'

class App
  def initialize
    system('clear')
    CartService.setup
    Menu.start
  end
end

App.new
