DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")
  .map(&.gsub("F", "0").gsub("B", 1).gsub("L", 0).gsub("R", 1).to_i(2))
  .sort

# Part 1
puts INPUT.last

# Part 2
puts (0..INPUT.last).find { |val|
  (val - 1..val + 1).to_a.map { |v| INPUT.includes?(v) } == [true, false, true]
}
