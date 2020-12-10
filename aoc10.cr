require "big"

DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.to_big_i).sort

def part1
  input = [0.to_big_i] + INPUT.clone + [INPUT.max + 3]
  input = input.each_cons(2).to_a.map { |arr| arr.last - arr.first }
  {input.count(1), input.count(3)}.product
end

def part2
  adapters = Hash(BigInt, BigInt).new { 0.to_big_i }
  adapters[0.to_big_i] = 1.to_big_i
  INPUT.each do |j|
    adapters[j] += adapters[j - 1] + adapters[j - 2] + adapters[j - 3]
  end
  adapters.max_of { |_, val| val }
end

puts part1
puts part2
