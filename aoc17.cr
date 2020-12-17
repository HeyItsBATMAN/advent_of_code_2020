DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.chars.map { |c| c == '#' ? true : false })

def count_neighbours(map, z, y, x)
  count = 0
  (-1..1).each { |dz| (-1..1).each { |dy| (-1..1).each { |dx|
    next if dz == 0 && dy == 0 && dx == 0
    state = map[{z + dz, y + dy, x + dx}]?
    next if !state
    count += 1
  } } }
  count
end

def cycle(map)
  next_map = map.clone

  zrange = map.keys.minmax_of { |coord| coord[0] }
  yrange = map.keys.minmax_of { |coord| coord[1] }
  xrange = map.keys.minmax_of { |coord| coord[2] }

  (zrange.first - 1..zrange.last + 1).each do |z|
    (yrange.first - 1..yrange.last + 1).each do |y|
      (xrange.first - 1..xrange.last + 1).each do |x|
        cube = map[{z, y, x}]?
        count = count_neighbours(map, z, y, x)
        if cube
          next_map[{z, y, x}] = count == 2 || count == 3
        else
          next_map[{z, y, x}] = count == 3
        end
      end
    end
  end

  next_map.clone
end

def count_neighbours_4dim(map, z, y, x, w)
  count = 0
  (-1..1).each { |dz| (-1..1).each { |dy| (-1..1).each { |dx| (-1..1).each { |dw|
    next if dz == 0 && dy == 0 && dx == 0 && dw == 0
    state = map[{z + dz, y + dy, x + dx, w + dw}]?
    next if !state
    count += 1
  } } } }
  count
end

def cycle_4dim(map)
  next_map = map.clone

  zrange = map.keys.minmax_of { |coord| coord[0] }
  yrange = map.keys.minmax_of { |coord| coord[1] }
  xrange = map.keys.minmax_of { |coord| coord[2] }
  wrange = map.keys.minmax_of { |coord| coord[3] }

  (zrange.first - 1..zrange.last + 1).each do |z|
    (yrange.first - 1..yrange.last + 1).each do |y|
      (xrange.first - 1..xrange.last + 1).each do |x|
        (wrange.first - 1..wrange.last + 1).each do |w|
          cube = map[{z, y, x, w}]?
          count = count_neighbours_4dim(map, z, y, x, w)
          if cube
            next_map[{z, y, x, w}] = count == 2 || count == 3
          else
            next_map[{z, y, x, w}] = count == 3
          end
        end
      end
    end
  end

  next_map.clone
end

def print_map(map)
  zrange = map.keys.minmax_of { |coord| coord[0] }
  yrange = map.keys.minmax_of { |coord| coord[1] }
  xrange = map.keys.minmax_of { |coord| coord[2] }
  (zrange.first..zrange.last).each { |z|
    puts "z: #{z}"
    (yrange.first..yrange.last).each { |y|
      puts (xrange.first..xrange.last).to_a
        .map { |x| map[{z, y, x}]? ? '#' : '.' }.join
    }
    puts
  }
end

def part1
  map = Hash(Tuple(Int32, Int32, Int32), Bool).new
  INPUT.each_with_index do |line, y|
    line.each_with_index do |state, x|
      map[{0, y, x}] = state
    end
  end

  6.times do
    map = cycle(map)
  end

  map.values.count(true)
end

def part2
  map = Hash(Tuple(Int32, Int32, Int32, Int32), Bool).new
  INPUT.each_with_index do |line, y|
    line.each_with_index do |state, x|
      map[{0, y, x, 0}] = state
    end
  end

  6.times do
    map = cycle_4dim(map)
  end

  map.values.count(true)
end

puts part1
puts part2
