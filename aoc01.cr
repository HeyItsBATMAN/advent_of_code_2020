require "benchmark"

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

part1time = Benchmark.realtime { puts part1 }.total_milliseconds
puts "Part 1\t#{part1time}ms"
part2time = Benchmark.realtime { puts part2 }.total_milliseconds
puts "Part 2\t#{part2time}ms"
