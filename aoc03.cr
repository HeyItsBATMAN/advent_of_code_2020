DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

SLOPES = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
TREES  = [0, 0, 0, 0, 0]

width = INPUT.first.size
INPUT.each_with_index do |line, line_index|
  SLOPES.each_with_index do |slope, slope_index|
    x, y = slope
    next if line_index % y != 0
    tree = line[(x * line_index) % width]
    TREES[slope_index] += 1 if tree == '#'
  end
end

puts TREES[1]
puts TREES.map(&.to_u64).product
