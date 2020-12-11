DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.chars)
YSIZE = INPUT.size
XSIZE = INPUT.first.size

def visible_occupied(input, y, x, stop_at_first = true)
  count = 0
  (-1..1).each { |dy| (-1..1).each { |dx|
    next if dy == 0 && dx == 0
    (1..Int32::MAX).each do |distance|
      my, mx = y + (dy * distance), x + (dx * distance)
      break if my < 0 || my >= YSIZE || mx < 0 || mx >= XSIZE
      seat = input[my][mx]
      count += 1 if seat == '#'
      break if seat != '.'
      break if stop_at_first
    end
  } }
  count
end

def iteration(input, stop_at_first = true, occupied_limit = 4)
  next_iter = input.clone
  input.size.times { |y| input.first.size.times { |x|
    seat = input[y][x]
    next if seat == '.'
    occupied = visible_occupied(input, y, x, stop_at_first)
    next_iter[y][x] = '#' if seat == 'L' && occupied == 0
    next_iter[y][x] = 'L' if seat == '#' && occupied >= occupied_limit
  } }
  next_iter
end

def solve(input = INPUT.clone, stop_at_first = true, occupied_limit = 4)
  while next_iter = iteration(input, stop_at_first, occupied_limit)
    return input.sum { |row| row.count('#') } if next_iter == input
    input = next_iter
  end
end

puts solve(stop_at_first: true, occupied_limit: 4)
puts solve(stop_at_first: false, occupied_limit: 5)
