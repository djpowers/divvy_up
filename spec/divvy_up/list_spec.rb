module DivvyUp
  describe List do
    let(:shopping_list) { {
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
    }

    it "exists" do
      expect(DivvyUp::List)
    end

    it "creates a new list" do
      list = DivvyUp::List.new({juice: 3, apple: 1.20, chicken: 7.99})
      expect(list.items).to eql({juice: 3, apple: 1.20, chicken: 7.99})
    end

    it "splits a list into one group" do
      list = DivvyUp::List.new(shopping_list)
      expect(list.split(1)).to eql([shopping_list])
    end

    it "splits a two-item list into two groups" do
      list = DivvyUp::List.new({carrots: 2.50, celery: 2})
      expect(list.split(2)).to eql([[{carrots: 2.50}, 2.50], [{celery: 2}, 2.0]])
    end

    it "splits a small list into two groups" do
      list = DivvyUp::List.new({apples: 1.20, bananas: 2.40,
                                pears: 3.20, melon: 4.60})
      expect(list.split(2)).to eql([[{apples: 1.20, melon: 4.60}, 5.80],
                                   [{bananas: 2.40, pears: 3.20}, 5.60]])
    end

    it "splits a list into three groups" do
      list = DivvyUp::List.new(shopping_list)
      expect(list.split(3)).to eql(
        [
          [{orange_juice: 3, eggs: 2.79, carrots: 2.5, onion: 1.25, celery: 1.69}, 11.23],
          [{lettuce: 7, strawberries: 3, tomato: 1.25}, 11.25],
          [{blueberries: 3.99, butter: 2.69, pasta_sauce: 2.5, pepper: 2}, 11.18]
        ]
      )
    end

    it "splits a list using the 'snake' technique" do
      shopping_list = { orange_juice: 3, colored_pepper: 1.99, spring_mix_7_oz: 4.99, pasta_sauce: 2.50, blueberries: 3.99, onion: 1.25 }
      list = DivvyUp::List.new(shopping_list)
      expect(list.split(3)).to eql(
        [
          [{spring_mix_7_oz: 4.99, onion: 1.25}, 6.24],
          [{blueberries: 3.99, colored_pepper: 1.99}, 5.98],
          [{orange_juice: 3, pasta_sauce: 2.5}, 5.5]
        ]
      )
    end

    it "splits a list using the 'price is right' technique" do
      shopping_list = { milk: 2.49, bread: 1.99, cheese: 3.50, celery: 2.99, yogurt: 2.99, ham: 4.99, potatoes: 2, belvita_bars: 3.49, rice: 5, chicken: 6.49 }
      list = DivvyUp::List.new(shopping_list)
      expect(list.split(3)).to eql(
        [
          [{chicken: 6.49, rice: 5}, 11.49],
          [{ham: 4.99, cheese: 3.5, belvita_bars: 3.49}, 11.98],
          [{yogurt: 2.99, celery: 2.99, milk: 2.49, potatoes: 2, bread: 1.99}, 12.46]
        ]
      )
    end

    it "splits a large list into three groups" do
      shopping_list = { orange_juice: 3, eggs_dozen_1: 2.99, eggs_dozen_2: 2.99, frozen_strawberries: 2.99, spring_mix: 4.99, bacon: 4.99, onion: 1.25, rasberries: 3.99, paper_towels: 1.59 }
      list = DivvyUp::List.new(shopping_list)
      expect(list.split(2)).to eql(
        [
          [{orange_juice: 3, spring_mix: 4.99, bacon: 4.99, onion: 1.25}, 14.23],
          [{eggs_dozen_1: 2.99, eggs_dozen_2: 2.99, frozen_strawberries: 2.99, rasberries: 3.99, paper_towels: 1.59}, 14.55]
        ]
      )
    end

    it "splits a large list into three groups" do
      shopping_list = { orange_juice_1: 3, orange_juice_2: 3, eggs_dozen: 2.99, spring_mix_16_oz: 6.99, bacon: 4.99, pasta_sauce: 2.50, blueberries: 3.99, frozen_strawberries: 2.99, olive_oil: 8.99, paper_towels: 1.59, toilet_paper: 1.99, aluminum_foil: 3 }
      list = DivvyUp::List.new(shopping_list)
      expect(list.split(3)).to eql(
        [
          [{olive_oil:8.99, orange_juice_1:3, orange_juice_2:3, paper_towels:1.59}, 16.58],
          [{spring_mix_16_oz:6.99, aluminum_foil:3, frozen_strawberries:2.99, toilet_paper:1.99}, 14.97],
          [{bacon:4.99, blueberries:3.99, eggs_dozen:2.99, pasta_sauce:2.5}, 14.47]
        ]
      )
    end
  end
end
