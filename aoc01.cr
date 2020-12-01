require "benchmark"

# Read real input from file
DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.to_i)

def part1
  INPUT.combinations(2).select { |nums| nums.sum == 2020 }.first.product
end

def part2
  INPUT.combinations(3).select { |nums| nums.sum == 2020 }.first.product
end

puts "Part 1\t" + Benchmark.realtime { puts part1 }.to_s
puts "Part 2\t" + Benchmark.realtime { puts part2 }.to_s
