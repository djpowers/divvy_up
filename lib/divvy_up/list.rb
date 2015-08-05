module DivvyUp
  class List
    attr_reader :items

    def initialize(items)
      @items = parse_items(items)
    end

    def split(groups)
      @groups = groups
      return [self.items] if @groups == 1
      determine_best_result
    end

    private

    def parse_items(items)
      quantified_items = {}
      items.each do |item, attributes|
        next if attributes.is_a? Numeric
        items[item] = attributes[:price]
        if attributes[:quantity]
          attributes[:quantity].times do |index|
            item_name = (item.to_s + '_' + (index + 1).to_s).to_sym
            quantified_items[item_name] = attributes[:price]
            items.delete(item)
          end
        end
      end
      items.merge(quantified_items)
    end

    def permute
      sublists = sublist_permutations
      price_differences = sublist_price_differences(sublists)
      sublist_options_sorted = sort_sublist_options(price_differences)
      output_final_sublists(sublist_options_sorted)
    end

    def snake
      unassigned_items = self.items.sort_by { |item, price| price }.to_a
      permutations = []
      @groups.times { permutations << {} }
      until unassigned_items.empty? do
        permutations.each do |permutation|
          permutation[unassigned_items.last.first] = unassigned_items.last.last unless unassigned_items.empty?
          unassigned_items.pop
        end
        permutations.reverse_each do |permutation|
          permutation[unassigned_items.last.first] = unassigned_items.last.last unless unassigned_items.empty?
          unassigned_items.pop
        end
      end
      output_final_sublists(permutations)
    end

    def price_is_right
      unassigned_items = self.items.sort_by { |item, price| price }.to_a
      permutations = []
      @groups.times { permutations << {} }
      permutations.each do |permutation|
        total = 0
        until total > target_amount || unassigned_items.empty? do
          next_item = unassigned_items.pop
          permutation[next_item.first] = next_item.last
          total = permutation.values.reduce(:+).nil? ? 0 : permutation.values.reduce(:+)
          if total > target_amount
            permutation.delete(next_item.first)
            unassigned_items << next_item
          end unless permutation == permutations.last || permutation.count == 1
        end
      end
      output_final_sublists(permutations)
    end

    def target_amount
      (self.items.values.reduce(:+) / @groups).round(2)
    end

    def sublist_permutations
      sublists = []
      self.items.keys.size.times do |n|
        self.items.keys.combination(n+1).collect {|x| sublists << x}
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
        price_differences[permutation] = (target_amount - total).abs
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
      sublist_options_sorted.each do |list|
        if (accounted_items & list.keys).empty?
          sublists << [list, (list.values.reduce(:+)).round(2)]
          accounted_items << list.keys
          accounted_items.flatten!
        end
      end
      sublists = nil if sublists.count > @groups
      sublists
    end

    def determine_best_result
      permute_result = permute
      snake_result = snake
      price_is_right_result = price_is_right
      results = [permute_result, snake_result, price_is_right_result]
      results.delete(nil)
      result_differences = []
      results.each do |result|
        result_totals = []
        result.each do |list|
          result_totals << list.last
        end
        min_difference = (result_totals.min - target_amount).abs
        max_difference = (result_totals.max - target_amount).abs
        result_differences << (min_difference > max_difference ? min_difference : max_difference)
      end
      results[result_differences.index(result_differences.min)]
    end
  end
end
