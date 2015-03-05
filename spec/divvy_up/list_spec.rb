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

    it "split a two-item list into two groups" do
      list = DivvyUp::List.new({carrots: 2.50, celery: 2})
      expect(list.split(2)).to eql([{carrots: 2.50}, {celery: 2}])
    end

    it "splits a small list into two groups" do
      list = DivvyUp::List.new({apples: 1.20, bananas: 2.40,
                                pears: 3.20, melon: 4.60})
      expect(list.split(2)).to eql([{apples: 1.20, melon: 4.60},
                                   {bananas: 2.40, pears: 3.20}])
    end
  end
end
