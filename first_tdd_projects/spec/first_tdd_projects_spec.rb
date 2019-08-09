require 'rspec'
require 'first_tdd_projects'

describe "#my_uniq" do
  let(:array) { [3, 1, 2, 1, 3] }

  it "returns the unique elements in order of first appearance" do
    expect(my_uniq(array)).to eq([3, 1, 2])
  end

  it "returns a new array" do
    expect(my_uniq(array)).to be_an(Array)
    expect(my_uniq(array)).not_to be(array)
  end
end

describe "Array#two_sum" do
  subject(:array) { [-1, 0, 2, -2, 1] }

  it "returns an array" do
    expect(array.two_sum).to be_an(Array)
  end

  it "finds all pairs of positions where elements at positions sum to zero" do
    expect(array.two_sum).to contain_exactly(
      a_collection_containing_exactly(4,0),
      a_collection_containing_exactly(3,2)
    )
  end

  it "lists pairs with smaller index before larger index" do
    expect(array.two_sum).to contain_exactly([2,3], [0,4])
  end

  it "sorts pairs 'dictionary-wise'" do
    expect(array.two_sum).to eq([[0,4], [2,3]])
  end
end

describe "#my_transpose" do
  let(:row_oriented) { [
    [0, 1, 2],
    [3, 4, 5]
  ]}

  let(:column_oriented) { [
    [0, 3],
    [1, 4],
    [2, 5]
  ]}

  it "returns a new array" do
    expect(my_transpose(row_oriented)).to be_an(Array)
    expect(my_transpose(row_oriented)).not_to be(row_oriented)
  end

  context "when it receives an empty array" do
    it "returns an empty array" do
      expect(my_transpose([])).to eq([])
    end
  end

  context "when it receives an m x n matrix" do
    it "returns an n x m matrix" do
      expect(my_transpose(row_oriented).length).to eq(3)
      expect(my_transpose(row_oriented).all? { |col| col.length == 2 }).to be true
    end

    it "exchanges the rows and columns of a matrix" do
      expect(my_transpose(row_oriented)).to eq(column_oriented)
      expect(my_transpose(column_oriented)).to eq(row_oriented)
    end
  end
end

describe "#stock_picker" do
  let(:prices) { [10000, 5, 42, 7, 43] }
  let(:bad_prices) { [10, 9, 8, 7, 0] }

  it "returns nil if stock price only declines" do
    expect(stock_picker(bad_prices)).to be_nil
  end

  it "does not sell stock before buying it" do
    expect(stock_picker(prices).first).to be < stock_picker(prices).last 
  end

  it "outputs the most profitable pair of days" do
    expect(stock_picker(prices)).to eq([1,4])
  end
end

describe "TowersOfHanoi" do
  subject(:game) { TowersOfHanoi.new }

  describe "#initialize" do
    it "creates three towers" do
      expect(game.towers.length).to be(3)
    end

    it "stacks up discs only in the first tower" do
      expect(game.towers[0]).not_to be_empty
      expect(game.towers[1]).to be_empty
      expect(game.towers[2]).to be_empty
    end
    
    it "stacks up discs in descending order" do
      expect(game.towers[0]).not_to be_empty
      expect(game.towers[0]).to eq(game.towers[0].sort.reverse)
    end
  end

  describe "#move" do
    before(:each) { game.move(1, 3) }

    it "accepts two integers as arguments" do
      expect { game.move(1, 2) }.not_to raise_error
    end
    
    it "raises an error unless both integers are between 1 and 3" do
      expect { game.move(0, 3) }.to raise_error(ArgumentError)
    end

    it "removes the top disc from the start tower" do
      expect(game.towers[0].last).to eq(2)
    end

    it "removes the top disc from the start tower" do
      expect(game.towers[0].last).to eq(2)
    end
    
    it "places the disc on the second tower" do
      expect(game.towers[2].last).to eq(1)
    end
    
    context "when the first tower is empty" do
      it "raises an error" do
        expect { game.move(2, 3) }.to raise_error(ArgumentError)
      end
    end

    context "when the disc is bigger than the top disc on the new tower" do
      it "raises an error" do
        expect { game.move(1,3) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#won?" do
    it "returns true when all discs are on the third tower" do
      game.move(1,2)
      game.move(1,3)
      game.move(2,3)
      game.move(1,2)
      game.move(3,1)
      game.move(3,2)
      game.move(1,2)
      game.move(1,3)
      game.move(2,3)
      game.move(2,1)
      game.move(3,1)
      game.move(2,3)
      game.move(1,2)
      game.move(1,3)
      game.move(2,3)

      expect(game.won?).to be true
    end
    
    it "returns false otherwise" do
      expect(game.won?).to be false
    end
  end
end