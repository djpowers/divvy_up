module DivvyUp
  describe List do

    it "exists" do
      expect(DivvyUp::List)
    end

    it "creates a new list" do
      list = DivvyUp::List.new({juice: 3, apple: 1.20, chicken: 7.99})
      expect(list.items).to eql({juice: 3, apple: 1.20, chicken: 7.99})
    end

    it "splits a list into one group" do
      items = {
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
      list = DivvyUp::List.new(items)
      expect(list.split(1)).to eql([items])
    end
  end
end