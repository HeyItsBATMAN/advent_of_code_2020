DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.chars.map { |c| c == '#' })
MAP   = Hash(Tuple(Int32, Int32, Int32, Int32), Bool).new
INPUT.size.times { |y| INPUT[0].size.times { |x| MAP[{0, y, x, 0}] = INPUT[y][x] } }

def count_neighbours(map, coord, hyper = false)
  count = 0
  range = (-1..1)
  z, y, x, w = coord
  wrange = hyper ? range : (0..0)
  range.each { |dz| range.each { |dy| range.each { |dx| wrange.each { |dw|
    next if dz == 0 && dy == 0 && dx == 0 && dw == 0
    next if count >= 5
    count += 1 if map[{z + dz, y + dy, x + dx, w + dw}]?
  } } } }
  count
end

def get_range(map, coord_index)
  minmax = map.keys.minmax_of { |coord| coord[coord_index] }
  (minmax.first - 1..minmax.last + 1)
end

def cycle(map, hyper = false)
  next_map = map.clone

  zr, yr, xr, wr = get_range(map, 0), get_range(map, 1), get_range(map, 2), get_range(map, 3)
  wr = (0..0) if !hyper

  zr.each { |z| yr.each { |y| xr.each { |x| wr.each { |w|
    coord = {z, y, x, w}
    cube = map[coord]?
    count = count_neighbours(map, coord, hyper)
    next_map[coord] = cube ? count == 2 || count == 3 : count == 3
  } } } }

  next_map
end

def part1(map = MAP.clone)
  6.times { map = cycle(map, false) }
  map.values.count(true)
end

def part2(map = MAP.clone)
  6.times { map = cycle(map, true) }
  map.values.count(true)
end

puts part1
puts part2
