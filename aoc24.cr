DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

alias Pos = Tuple(Int32, Int32)

def add_pos(a, b)
  {a.first + b.first, a.last + b.last}
end

def initial_flipping
  movements = {"nw" => {0, -1}, "w" => {-1, -1}, "sw" => {-1, 0},
               "ne" => {1, 0}, "e" => {1, 1}, "se" => {0, 1}}
  tiles = Hash(Pos, Bool).new
  start_pos = {0, 0}
  INPUT.each do |line|
    pos = start_pos.clone
    until line.empty?
      token = line[0, 2]
      dir = ["se", "sw", "nw", "ne"].find { |d| d == token } || token[0].to_s
      dir.size.times { line = line.lchop }
      pos = add_pos(pos, movements[dir])
      tiles[pos] = true if tiles[pos]? == nil
      tiles[pos] = tiles[pos]? == nil ? false : !tiles[pos] if line.empty?
    end
  end
  tiles
end

def part1
  initial_flipping.values.count(false)
end

def part2
  movements = [{0, -1}, {-1, -1}, {-1, 0}, {1, 0}, {1, 1}, {0, 1}]
  tiles = initial_flipping
  100.times do
    next_tiles = Hash(Pos, Bool).new
    # expand map
    tiles.each { |pos, _| movements.each { |m|
      p = add_pos(pos, m)
      tiles[p] = true if tiles[p]? == nil
    } }
    # apply state changes
    tiles.each do |pos, state|
      adj_black = movements.map { |m| add_pos(pos, m) }.map { |p|
        tiles[p]? == nil ? true : tiles[p]
      }.count(false)

      next_tiles[pos] = state ? adj_black != 2 : adj_black == 0 || adj_black > 2
    end
    tiles = tiles.merge(next_tiles)
  end
  tiles.values.count(false)
end

puts part1
puts part2
