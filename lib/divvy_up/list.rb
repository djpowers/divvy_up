module DivvyUp
  class List
    attr_reader :items

    def initialize(items)
      @items = items
    end

    def split(groups)
      return [self.items] if groups == 1
      determine_best_result(groups)
    end

    private

    def permute(groups)
      permutations = generate_list_permutations
      permutation_price_differences = calculate_permutation_price_differences(permutations, groups)
      sorted_price_differences = generate_list_combinations(permutation_price_differences)
      list_possibilities = find_full_list(permutation_price_differences, sorted_price_differences)
      calculate_list_totals(list_possibilities, groups)
    end

    def snake(groups)
      unassigned_items = self.items.sort_by { |item, price| price }.to_a
      permutations = []
      groups.times { permutations << {} }
      until unassigned_items.empty? do
        permutations.each do |permutation|
          permutation[unassigned_items.last.first] = unassigned_items.last.last
          unassigned_items.pop
        end
        permutations.reverse_each do |permutation|
          permutation[unassigned_items.last.first] = unassigned_items.last.last unless unassigned_items.empty?
          unassigned_items.pop
        end
      end
      calculate_list_totals(permutations, groups)
    end

    def price_is_right(groups)
      unassigned_items = self.items.sort_by { |item, price| price }.to_a
      permutations = []
      groups.times { permutations << {} }
      permutations.each do |permutation|
        total = 0
        until total > target_amount(groups) || unassigned_items.empty? do
          next_item = unassigned_items.pop
          permutation[next_item.first] = next_item.last
          total = permutation.values.reduce(:+).nil? ? 0 : permutation.values.reduce(:+)
          if total > target_amount(groups)
            permutation.delete(next_item.first)
            unassigned_items << next_item
          end unless permutation == permutations.last
        end
      end
      calculate_list_totals(permutations, groups)
    end

    def target_amount(divisor)
      (self.items.values.reduce(:+) / divisor).round(2)
    end

    def generate_list_permutations
      permutations = []
      self.items.keys.size.times do |n|
        sets = self.items.keys.combination(n+1)
        sets.each do |set|
          permutations << set
        end
      end
      permutations
    end

    def calculate_permutation_price_differences(permutations, divisor)
      permutation_price_differences = {}
      permutations.each do |permutation|
        total = 0.0
        permutation.each_with_index do |item, n|
          total += self.items[item]
        end
        permutation_price_differences[permutation] = (target_amount(divisor) - total).abs
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

    def calculate_list_totals(lists, groups)
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

    def determine_best_result(groups)
      permute(groups)
    end
  end
end
