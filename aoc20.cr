DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read("#{DAY}.txt").strip.split("\n\n").map(&.split("\n"))
TILES = Array(Tile).new

class Tile
  getter id
  property data

  def initialize(@id : Int32, @data : Array(String))
  end

  def to_s(io)
    io << "T<#{self.id}>"
  end

  def flip
    tile = self.clone
    tile.data = tile.map(&.reverse)
    tile
  end

  def rotate_right
    tile = self.clone
    tile.data = tile.map(&.chars).transpose.map(&.reverse.join(""))
    tile
  end

  def right
    self.map { |row| row[row.size - 1] }.join
  end

  def left
    self.map { |row| row[0] }.join
  end

  def sides
    [self.first, self.right, self.last, self.left]
  end

  def all_sides
    [self.sides, self.sides.map(&.reverse)].flatten
  end

  def_equals_and_hash @id
  def_clone
  forward_missing_to @data
end

INPUT.each do |tile|
  next if tile.first.empty?
  tile_identifier = tile.shift.tr(":", "").split(" ").last.to_i
  TILES << Tile.new(tile_identifier, tile)
end

def find_adjacent(tile : Tile)
  TILES.select { |other| tile != other && !(tile.sides & other.all_sides).empty? }
end

# Part 1
corners = TILES.select { |t| find_adjacent(t).size == 2 }
puts corners.map(&.id.to_u64).product

# Part 2
GRID_SIZE = Math.sqrt(INPUT.size).to_i

def get_orientations(start : Tile)
  arr = [start.clone]
  3.times { arr << arr.last.rotate_right }
  arr << start.clone.flip
  3.times { arr << arr.last.rotate_right }
  arr
end

def find_right_adjacent(tile : Tile, tiles_remaining : Array(Tile))
  tiles_remaining.each do |other|
    ori = get_orientations(other).find { |o| tile.right == o.left }
    return ori if ori
  end
end

def build_row(starting_tile : Tile, tiles_remaining = TILES.clone)
  tiles_remaining.delete(starting_tile)
  row = [starting_tile]
  until row.size == GRID_SIZE
    next_tile = find_right_adjacent(row.last, tiles_remaining) || return
    tiles_remaining.delete(next_tile)
    row << next_tile
  end
  row
end

GRID = Array(Array(Tile)).new
corners.each do |starting_corner|
  break if !GRID.empty?
  grid = Array(Array(Tile)).new
  get_orientations(starting_corner).each do |orientation|
    break if !GRID.empty?
    tiles_remaining = TILES.clone
    grid.clear
    first_row = build_row(orientation, tiles_remaining)
    next if !first_row
    # Rotate first row left
    grid << first_row.map(&.rotate_right)
    grid = grid.transpose

    # Build remaining rows
    restart = false
    grid.each do |row|
      full_row = build_row(row.first, tiles_remaining)
      if !full_row
        restart = true
        break
      end
      GRID << full_row
    end
    GRID.clear if restart
  end
end

# Remove borders
grid = GRID.map(&.map(&.data.rotate(-1).skip(2).map(&.lchop.rchop)))
lines = Array(String).new
grid.each { |tr| tr.first.size.times { |i| lines << tr.map { |t| t[i] }.join } }

# Generate map orientations
oris = [lines]
3.times { oris << oris.last.map(&.chars).transpose.map(&.reverse.join("")) }
oris << lines.clone.map(&.reverse)
3.times { oris << oris.last.map(&.chars).transpose.map(&.reverse.join("")) }

# Find monster in orientations
FINE_MATCH = /(.{18}#.\n#.{4}##.{4}##.{4}###\n.#.{2}#.{2}#.{2}#.{2}#.{2}#.{3})/
monster_size, monster_width = 15, 20

oris.each do |ori|
  monster_count = 0
  ori.each_cons(3) do |group|
    (0..group.first.size - monster_width).each do |i|
      smaller_group = group.map { |line| line[i, monster_width] }.join("\n")
      monster_count += 1 if smaller_group.matches?(FINE_MATCH)
    end
  end
  next if monster_count == 0
  puts ori.join("\n").count('#') - (monster_count * monster_size)
  break
end
