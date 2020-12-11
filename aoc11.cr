DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.chars)

def count_adjacent_occupied(input, y, x)
  dy, dx = (-1..1), (-1..1)
  count = 0
  dy.each { |yy| dx.each { |xx|
    my, mx = yy + y, xx + x
    next if my < 0 || my >= input.size
    next if mx < 0 || mx >= input.first.size
    next if yy == 0 && xx == 0
    row = input[my]?
    next if !row
    seat = row[mx]?
    next if !seat
    count += 1 if seat == '#'
  } }
  count
end

def visible_occupied(input, y, x)
  dy, dx = (-1..1), (-1..1)
  count = 0
  dy.each { |yy| dx.each { |xx|
    next if yy == 0 && xx == 0
    distance = 0
    while true
      distance += 1
      my, mx = y + (yy * distance), x + (xx * distance)
      break if my < 0 || my >= input.size
      break if mx < 0 || mx >= input.first.size
      row = input[my]?
      break if !row
      seat = row[mx]?
      break if !seat
      if seat == '#'
        count += 1
        break
      elsif seat == 'L'
        break
      end
    end
  } }
  count
end

def iteration(input)
  next_iter = input.clone
  input.size.times { |y| input.first.size.times { |x|
    seat = input[y][x]
    next if seat == '.'
    occupied = count_adjacent_occupied(input, y, x)
    next_iter[y][x] = '#' if seat == 'L' && occupied == 0
    next_iter[y][x] = 'L' if seat == '#' && occupied >= 4
  } }
  next_iter
end

def iteration_complex(input)
  next_iter = input.clone
  input.size.times { |y| input.first.size.times { |x|
    seat = input[y][x]
    next if seat == '.'
    occupied = visible_occupied(input, y, x)
    next_iter[y][x] = '#' if seat == 'L' && occupied == 0
    next_iter[y][x] = 'L' if seat == '#' && occupied >= 5
  } }
  next_iter
end

def part1
  input = INPUT.clone
  counter = 0
  while true
    counter += 1
    next_iter = iteration(input)
    break if next_iter.map(&.join).join == input.map(&.join).join
    input = next_iter
  end
  input.sum { |row| row.count('#') }
end

def part2
  input = INPUT.clone
  counter = 0
  while true
    counter += 1
    next_iter = iteration_complex(input)
    break if next_iter.map(&.join).join == input.map(&.join).join
    input = next_iter
  end
  input.sum { |row| row.count('#') }
end

puts "#{part1} should eq 2093"
puts "#{part2} should eq 1862"
