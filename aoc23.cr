DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").first.chars.map(&.to_i)

def solve(map, rounds)
  current_cup, max, held_cups = INPUT.first, map.values.max, Array(Int32).new
  rounds.times do
    # hold cups
    head = map[current_cup]
    3.times do
      held_cups << head
      head = map[head]
    end

    # find next valid
    next_cup = current_cup == 1 ? max : current_cup - 1
    while held_cups.includes?(next_cup)
      next_cup = next_cup == 1 ? max : next_cup - 1
    end

    # swaps
    temp = map[next_cup]
    map[next_cup] = held_cups.first
    map[current_cup] = map[held_cups.last]
    map[held_cups.last] = temp

    # prepare for next round
    current_cup = map[current_cup]
    held_cups.clear
  end
  map
end

def part1
  map = INPUT.clone.push(INPUT.first).each_cons(2).to_h
  map = solve(map, 100)
  current_cup = map[1]
  result = [] of Int32
  until current_cup == 1
    result << current_cup
    current_cup = map[current_cup]
  end
  result.join
end

def part2
  map = (INPUT + (10..1_000_000).to_a).each_cons(2).to_h
  map[1_000_000] = INPUT.first
  map = solve(map, 10_000_000)
  first = map[1].to_u64
  second = map[first].to_u64
  first * second
end

puts part1
puts part2
