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

def threesum
  input = INPUT.sort
  silver = false
  gold = false
  (0..input.size - 2).each do |i|
    a = input[i]
    start = i + 1
    stop = input.size - 1
    while start < stop
      b = input[start]
      c = input[stop]
      return if silver && gold
      if !silver
        if a + b == TOKEN
          puts a * b
          silver = true
        elsif b + c == TOKEN
          puts b * c
          silver = true
        elsif a + c == TOKEN
          puts a * c
          silver = true
        end
      end
      if a + b + c == TOKEN
        puts a * b * c
        gold = true
      elsif a + b + c > TOKEN
        stop -= 1
      else
        start += 1
      end
    end
  end
end

part1time = Benchmark.realtime { puts part1 }.total_milliseconds
puts "Part 1\t#{part1time}ms"
part2time = Benchmark.realtime { puts part2 }.total_milliseconds
puts "Part 2\t#{part2time}ms"
threesumtime = Benchmark.realtime { puts threesum }.total_milliseconds
puts "Threesum\t#{threesumtime}ms"
