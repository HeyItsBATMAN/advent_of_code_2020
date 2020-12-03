DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

SLOPES = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
TREES  = Array.new(SLOPES.size) { 0 }

width, height = INPUT.first.size, INPUT.size
SLOPES.each_with_index do |slope, slope_index|
  right, down = slope
  x, y = 0, 0
  until y >= height
    TREES[slope_index] += 1 if INPUT[y][x % width] == '#'
    x += right
    y += down
  end
end

puts TREES[1]
puts TREES.map(&.to_u64).product
