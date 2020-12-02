require "benchmark"

DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map { |line|
  m = line.match(/(\d+)-(\d+) (\w): (\w+)/).not_nil!
  {password: m[4], letter: m[3][0], nums: [m[1], m[2]].map(&.to_i)}
}

def part1
  INPUT.select { |pw|
    (pw[:nums].first..pw[:nums].last).covers? pw[:password].count pw[:letter]
  }.size
end

def part2
  INPUT.select { |pw|
    result = pw[:nums].map { |pos| pw[:password][pos - 1] == pw[:letter] }.uniq
    result.size == 2 && result.find { |b| b }
  }.size
end

part1time = Benchmark.realtime { puts part1 }.total_milliseconds
puts "Part 1\t#{part1time}ms"
part2time = Benchmark.realtime { puts part2 }.total_milliseconds
puts "Part 2\t#{part2time}ms"
