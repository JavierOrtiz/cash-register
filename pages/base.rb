require 'terminal-table'

class Base
  class << self
    def start
      raise NotImplementedError, "You must implement the start method"
    end

    def close
      raise NotImplementedError, "You must implement the close method"
    end

    def display_main
      raise NotImplementedError, "You must implement the display_main method"
    end

    def handle_action(chomp)
      raise NotImplementedError, "You must implement the handle_action method"
    end
  end
end