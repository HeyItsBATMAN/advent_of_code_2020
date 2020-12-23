DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").first.chars.map(&.to_i)

def part1
  input = Deque.new(INPUT.clone)
  lowest_cup, highest_cup = input.min, input.max
  hold = Deque(Int32).new
  input.rotate!(-1)
  100.times do
    input.rotate!(1)
    current_cup = input.first
    input.rotate!(1)
    3.times { hold << input.shift }
    next_cup = current_cup - 1
    until input.find { |cup| cup == next_cup }
      next_cup -= 1
      if next_cup < lowest_cup
        next_cup = highest_cup
      end
    end
    rots = input.index(next_cup)
    raise "No rots found" if !rots
    input.rotate!(rots + 1)
    3.times { input.unshift(hold.pop) }
    until input.first == current_cup
      input.rotate!(-1)
    end
    hold.clear
  end
  until input.first == 1
    input.rotate!(-1)
  end
  input.shift
  input.join
end

def part2
  input = Deque.new(INPUT.clone)
  (10..1_000_000).each { |num| input << num }
  lowest_cup, highest_cup = 1, 1_000_000
  hold = Deque(Int32).new
  input.rotate!(-1)
  puts
  10_000_000.times do |move|
    print "#{move}\r"
    input.rotate!(1)
    current_cup = input.first
    input.rotate!(1)
    3.times { hold << input.shift }
    next_cup = current_cup - 1
    until input.find { |cup| cup == next_cup }
      next_cup -= 1
      next_cup = highest_cup if next_cup < lowest_cup
    end
    rots = input.index(next_cup)
    raise "No rots found" if !rots
    input.rotate!(rots + 1)
    3.times { input.unshift(hold.pop) }
    until input.first == current_cup
      input.rotate!(-1)
    end
    hold.clear
  end
  puts
  until input.first == 1
    input.rotate!(-1)
  end
  input.shift
  star_cups = input.first(2)
  puts star_cups
  star_cups.map(&.to_u64).product
end

puts part1
puts part2
