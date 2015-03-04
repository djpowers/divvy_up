module DivvyUp
  class List
    attr_reader :items

    def initialize(items)
      @items = items
    end

    def split(groups)
      return [self.items] if groups == 1
      return [
              {self.items.keys[0] => self.items.values[0]},
              {self.items.keys[1] => self.items.values[1]}
             ]
    end
  end
end
