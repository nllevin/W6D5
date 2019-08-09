def my_uniq(array)
  uniqs = []
  array.each { |ele| uniqs << ele unless uniqs.include?(ele) }
  uniqs
end

class Array

  def two_sum
    pairs = []
    (0...length - 1).each do |idx1|
      (idx1 + 1...length).each do |idx2|
        pairs << [idx1, idx2] if self[idx1] + self[idx2] == 0
      end
    end
    pairs
  end
end

def my_transpose(array)
  return [] if array.empty?
  return array.dup if array.length == 1
  
  n = array.length
  m = array.first.length
  
  transposed = Array.new(m) { Array.new(n) }

  (0...n).each do |idx1|
    (0...m).each do |idx2|
      transposed[idx2][idx1] = array[idx1][idx2]
    end
  end

  transposed
end

def stock_picker(prices)
  best_profit = 0
  best_days  = nil

  (0...prices.length - 1).each do |buy_day|
    (buy_day + 1...prices.length).each do |sell_day|
      profit = prices[sell_day] - prices[buy_day]
      if profit > best_profit
        best_profit = profit
        best_days = [buy_day, sell_day]
      end
    end
  end
  best_days
end

class TowersOfHanoi
  attr_reader :towers

  def initialize(height = 4)
    @towers = Array.new(3) { [] }
    height.downto(1) { |disc| towers[0] << disc }
  end

  def move(start_tower, end_tower)
    raise ArgumentError unless [start_tower, end_tower].all? { |tow| tow.between?(1,3) }

    start_idx, end_idx = start_tower - 1, end_tower - 1
    raise ArgumentError if towers[start_idx].empty?
    raise ArgumentError if towers[end_idx].last && towers[start_idx].last > towers[end_idx].last

    towers[end_idx] << towers[start_idx].pop
  end

  def won?
    towers[0].empty? && towers[1].empty?
  end

  def play
    until won?
      display
      get_move
    end

    puts "You won!"
  end

  def display
    system("clear")
    puts "Let's play Towers of Hanoi!"
    towers.each_with_index { |tower, i| puts "#{(i + 1)}: #{tower}" }
  end

  def get_move
    puts "What tower do you want to move from?"
    start_tower = gets.chomp.to_i

    puts "What tower do you want to move to?"
    end_tower = gets.chomp.to_i

    move(start_tower, end_tower)
  rescue
    display
    puts "Don't you know how to play this game?"
    retry
  end
end