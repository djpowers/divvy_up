module DivvyUp
  class List
    attr_reader :items

    def initialize(items)
      @items = items
    end

    def split(number_of_groups)
      [self.items]
    end
  end
end
