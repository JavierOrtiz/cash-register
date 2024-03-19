class Memory
  @data = {}

  class << self
    def add(key, value)
      @data[key] = value
    end

    def get(key)
      @data[key]
    end

    def all
      @data.values
    end

    def delete(key)
      @data.delete(key)
    end

    def clear
      @data.clear
    end
  end
end