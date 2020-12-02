require "benchmark"

TOKEN = 2020
DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.to_i)

SUMS = Hash(Int32, Int32).new

def part1
  INPUT.each_combination(2) do |nums|
    sum = nums.sum
    next if sum > TOKEN
    SUMS[sum] = nums.product
  end
  SUMS[TOKEN]
end

def part2
  SUMS.each { |sum, product| INPUT.each { |num|
    return product * num if sum + num == TOKEN
  } }
end

part1time = Benchmark.realtime { puts part1 }.total_milliseconds
puts "Part 1\t#{part1time}ms"
part2time = Benchmark.realtime { puts part2 }.total_milliseconds
puts "Part 2\t#{part2time}ms"
