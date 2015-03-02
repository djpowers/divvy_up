module DivvyUp
  describe List do

    it "exists" do
      expect(DivvyUp::List)
    end

    it "creates a new list" do
      list = DivvyUp::List.new({juice: 3, apple: 1.20, chicken: 7.99})
      expect(list.items).to eql({juice: 3, apple: 1.20, chicken: 7.99})
    end
  end
end
