DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read("#{DAY}.txt")
  .split("\n\n")
  .map(&.split("\n").reject(&.empty?))
  .map(&.map(&.chars))

def part1
  INPUT.reduce(0) { |acc, group| acc + group.flatten.uniq.size }
end

def part2
  INPUT.reduce(0) { |acc, group| acc + group.reduce { |s, val| s & val }.size }
end

puts part1
puts part2
