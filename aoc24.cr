DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

alias Pos = Tuple(Int32, Int32)

def add_pos(a, b)
  {a.first + b.first, a.last + b.last}
end

def part1
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
      if line.empty?
        val = tiles[pos]?
        tiles[pos] = val == nil ? false : !tiles[pos]
      end
    end
  end
  tiles.values.count(false)
end

def part2
  input = INPUT.clone
  input.each do |line|
  end
  input
end

puts part1
# puts part2
