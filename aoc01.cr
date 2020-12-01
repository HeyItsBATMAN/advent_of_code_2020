require "benchmark"

# Read real input from file
DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.to_i)

SUMS = INPUT.combinations(2).to_h { |nums| {nums.sum, nums.product} }

def part1
  SUMS[2020]
end

def part2
  SUMS.each { |sum, product| INPUT.each { |num|
    return product * num if sum + num == 2020
  } }
end

puts "Part 1\t" + Benchmark.realtime { puts part1 }.to_s
puts "Part 2\t" + Benchmark.realtime { puts part2 }.to_s
