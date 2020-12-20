DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read("#{DAY}.txt").strip.split("\n\n").map(&.split("\n"))
TILES = Array(Tile).new

class Tile
  def initialize(@id : Int32, @data : Array(String))
  end

  def_equals_and_hash @id
  def_clone
  forward_missing_to @data

  def id
    @id
  end

  def to_s(io)
    io << self.id
  end

  def flip_y
    tile = self.clone
    tile.reverse!
    tile
  end

  def flip_x
    tile = self.clone
    tile.map!(&.reverse)
    tile
  end

  def rotate_left
    tile = self.clone
    row_len = tile.first.size
    row_len.times do |i|
      tile[i] = self.map { |row| row[row_len - i - 1] }.join
    end
    tile
  end

  def rotate_right
    tile = self.clone
    tile.rotate_left.flip_x.flip_y
  end

  def top
    self.first
  end

  def left
    self.map { |row| row[0] }.join
  end

  def bottom
    self.last
  end

  def right
    self.map { |row| row[row.size - 1] }.join
  end

  def sides
    [self.top, self.right, self.bottom, self.left]
  end

  def reverse_sides
    [self.top.reverse, self.right.reverse, self.bottom.reverse, self.left.reverse]
  end

  def all_sides
    [self.top, self.right, self.bottom, self.left, self.top.reverse, self.right.reverse, self.bottom.reverse, self.left.reverse]
  end
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
puts TILES.select { |t| find_adjacent(t).size == 2 }.map(&.id.to_u64).product
