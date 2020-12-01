require "benchmark"

# Read real input from file
# DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
# INPUT = File.read_lines("#{DAY}.txt")

# Test input
INPUT = ""
puts INPUT

def part1
  input = INPUT.clone
  nil
end

def part2
  input = INPUT.clone
  nil
end

part1time = Benchmark.realtime { puts part1 }.total_milliseconds
puts "Part 1\t#{part1time}ms"
part2time = Benchmark.realtime { puts part1 }.total_milliseconds
puts "Part 2\t#{part2time}ms"
