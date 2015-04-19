module DivvyUp
  class List
    attr_reader :items

    def initialize(items)
      @items = items
    end

    def split(groups)
      @groups = groups
      return [self.items] if @groups == 1
      sublists = sublist_permutations
      price_differences = sublist_price_differences(sublists)
      sublist_options_sorted = sort_sublist_options(price_differences)
      output_final_sublists(sublist_options_sorted)
    end

    private

    def target_amount(divisor)
      (self.items.values.reduce(:+) / divisor).round(2)
    end

    def sublist_permutations
      sublists = []
      self.items.keys.size.times do |n|
        sets = self.items.keys.combination(n+1)
        sets.each do |set|
          sublists << set
        end
      end
      sublists
    end

    def sublist_price_differences(permutations)
      price_differences = {}
      permutations.each do |permutation|
        total = 0.0
        permutation.each_with_index do |item, n|
          total += self.items[item]
        end
        price_differences[permutation] = (target_amount(@groups) - total).abs
      end
      price_differences
    end

    def sort_sublist_options(price_differences)
      list = []
      sorted_price_differences = price_differences.values.sort
      sorted_price_differences.each do |difference|
        if sorted_price_differences.count(difference) == 1
          list << price_differences.key(difference)
        else
          price_differences.find_all do |k,v|
            v == difference
          end.map(&:first).each do |permutation|
            list << permutation
          end
          sorted_price_differences.delete(difference)
        end
      end
      flattened_list = list.flatten
      if self.items.keys.sort == flattened_list.uniq.sort
        sublist_options_sorted = []
        list.each do |sublist|
          item_price = {}
          sublist.each do |item|
            item_price[item] = self.items[item]
          end
          sublist_options_sorted << item_price
        end
      end
      sublist_options_sorted
    end

    def output_final_sublists(sublist_options_sorted)
      sublists = []
      accounted_items = []
      until sublists.size == @groups
        sublist_options_sorted.each do |list|
          if (accounted_items & list.keys).empty?
            sublists << [list, (list.values.reduce(:+)).round(2)]
            accounted_items << list.keys
            accounted_items.flatten!
          end
        end
      end
      sublists
    end
  end
end
