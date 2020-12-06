DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read("#{DAY}.txt")
  .split("\n\n")
  .map(&.split("\n").reject(&.empty?))
  .map(&.map(&.chars))

puts INPUT.sum { |group| group.flatten.uniq.size }
puts INPUT.sum { |group| group.reduce { |s, val| s & val }.size }
