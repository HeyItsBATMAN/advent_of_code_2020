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

puts part1
puts part2
