require "benchmark"

DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map { |r| r.chars.map { |c| c == '#' } }

def trees(right, down)
  input = INPUT.clone
  x, y = 0, 0
  row_length = input.first.size
  counter = 0
  until y >= input.size
    tree = input[y][x % row_length]
    counter += 1 if tree

    x += right
    y += down
  end
  counter
end

def part1
  trees(3, 1)
end

def part2
  [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map { |s| trees(s[0], s[1]).to_u64 }.product
end

part1time = Benchmark.realtime { puts part1 }.total_milliseconds
puts "Part 1\t#{part1time}ms"
part2time = Benchmark.realtime { puts part2 }.total_milliseconds
puts "Part 2\t#{part2time}ms"
