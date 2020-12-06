DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read("#{DAY}.txt").split("\n\n").map(&.lines.map(&.chars))

puts INPUT.sum(&.flatten.uniq.size)
puts INPUT.sum(&.reduce { |s, val| s & val }.size)
