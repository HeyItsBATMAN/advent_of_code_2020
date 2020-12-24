DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

alias Pos = Tuple(Int32, Int32)

def add_pos(a, b)
  {a.first + b.first, a.last + b.last}
end

def initial_flipping
  input = INPUT.clone
  movements = {"nw" => {0, -1}, "w" => {-1, -1}, "sw" => {-1, 0},
               "ne" => {1, 0}, "e" => {1, 1}, "se" => {0, 1}}

  tiles = Hash(Pos, Bool).new

  start_pos = {0, 0}
  input.each do |line|
    pos = start_pos.clone
    until line.empty?
      token = line[0, 2]
      dir = ["se", "sw", "nw", "ne"].find { |d| d == token }
      if !dir
        dir = token[0].to_s
        line = line.lchop
      else
        2.times { line = line.lchop }
      end

      mvmt = movements[dir]
      pos = add_pos(pos, mvmt)

      tiles[pos] = true if tiles[pos]? == nil
      if line.empty?
        val = tiles[pos]?
        tiles[pos] = val == nil ? false : !tiles[pos]
      end
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
    tiles.each do |pos, _|
      movements.each { |mvmt|
        new_pos = add_pos(pos, mvmt)
        tiles[new_pos] = true if tiles[new_pos]? == nil
      }
    end

    # apply state changes
    tiles.each do |pos, state|
      adj_black = movements.map { |mvmt|
        new_pos = add_pos(pos, mvmt)
        tiles[new_pos] = true if tiles[new_pos]? == nil
        tiles[new_pos]
      }.count(false)
      case state
      when true # white
        next_tiles[pos] = adj_black != 2
      when false # black
        next_tiles[pos] = adj_black == 0 || adj_black > 2
      end
    end
    tiles = tiles.merge(next_tiles)
  end

  tiles.values.count(false)
end

puts part1
puts part2
