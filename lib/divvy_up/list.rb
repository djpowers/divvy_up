module DivvyUp
  class List
    attr_reader :items

    def initialize(items)
      @items = items
    end

    def split(groups)
      @groups = groups
      return [self.items] if @groups == 1
      permutations = sublist_permutations
      price_differences = sublist_price_differences(permutations)
      sorted_price_differences = generate_list_combinations(price_differences)
      list_possibilities = find_full_list(price_differences, sorted_price_differences)
      output_final_lists(list_possibilities, groups)
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
      permutation_price_differences = {}
      permutations.each do |permutation|
        total = 0.0
        permutation.each_with_index do |item, n|
          total += self.items[item]
        end
        permutation_price_differences[permutation] = (target_amount(@groups) - total).abs
      end
      permutation_price_differences
    end

    def generate_list_combinations(permutation_price_differences)
      permutation_price_differences.values.sort
    end

    def find_full_list(permutation_price_differences, sorted_price_differences)
      list = []
      sorted_price_differences.each do |difference|
        if sorted_price_differences.count(difference) == 1
          list << permutation_price_differences.key(difference)
        else
          permutation_price_differences.find_all{|k,v| v == difference}.map(&:first).each do |permutation|
            list << permutation
          end
          sorted_price_differences.delete(difference)
        end
      end
      flattened_list = list.flatten
      if self.items.keys.sort == flattened_list.uniq.sort
        output = []
        list.each do |sublist|
          item_price = {}
          sublist.each do |item|
            item_price[item] = self.items[item]
          end
          output << item_price
        end
      end
      output
    end

    def output_final_lists(lists, groups)
      output = []
      accounted_items = []
      until output.size == groups
        lists.each do |list|
          if (accounted_items & list.keys).empty?
            output << [list, (list.values.reduce(:+)).round(2)]
            accounted_items << list.keys
            accounted_items.flatten!
          end
        end
      end
      output
    end
  end
end
