# DivvyUp

[![Gem Version](https://badge.fury.io/rb/divvy_up.svg)](http://badge.fury.io/rb/divvy_up)

A Ruby gem to divvy up a list of item prices into smaller groups,
for the purpose of splitting up purchases (somewhat) equally.

A variation of sorts on the [knapsack problem](http://en.wikipedia.org/wiki/Knapsack_problem).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'divvy_up'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install divvy_up

## Usage

```ruby
shopping_list = {
  orange_juice: 3,
  lettuce: 7,
  strawberries: 3,
  eggs: 2.79,
  carrots: 2.5,
  onion: 1.25,
  tomato: 1.25,
  blueberries: 3.99,
  butter: 2.69,
  pasta_sauce: 2.5,
  pepper: 2,
  celery: 1.69
}

DivvyUp::List.new(shopping_list).split(3)
# =>
# [
#   [{:orange_juice=>3, :eggs=>2.79, :carrots=>2.5, :onion=>1.25, :celery=>1.69}, 11.23],
#   [{:lettuce=>7, :strawberries=>3, :tomato=>1.25}, 11.25],
#   [{:blueberries=>3.99, :butter=>2.69, :pasta_sauce=>2.5, :pepper=>2}, 11.18]
# ]
```

Output of `#split` method consists of an array of arrays, where each subarray
is a hash of items and the total value of those items.

## Contributing

1. Fork it ( https://github.com/djpowers/divvy_up/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
