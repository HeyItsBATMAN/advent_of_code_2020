DAY           = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT         = File.read_lines("#{DAY}.txt").map(&.to_u64)
PREAMBLE_SIZE = 25

def part1
  INPUT.each_index do |start_index|
    preamble = INPUT.skip(start_index).first(PREAMBLE_SIZE + 1)
    last = preamble.pop
    sums = preamble.combinations(2).map(&.sum)
    return last if !sums.includes?(last)
  end
end

def part2
  corrupted = part1 || 0
  input = INPUT.clone.select { |num| num < corrupted }
  input.each_index do |start_index|
    (2...input.size).each do |n|
      preamble = input.skip(start_index).first(n)
      sum = preamble.sum
      break if sum > corrupted
      return preamble.min + preamble.max if sum == corrupted
    end
  end
end

puts part1
puts part2
