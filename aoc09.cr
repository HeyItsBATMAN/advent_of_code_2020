DAY           = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT         = File.read_lines("#{DAY}.txt").map(&.to_u64)
PREAMBLE_SIZE = 25

def part1
  INPUT.each_cons(PREAMBLE_SIZE + 1) do |preamble|
    last = preamble.pop
    return last if !preamble.combinations(2).find { |nums| nums.sum == last }
  end
end

def part2
  corrupted = part1 || 0
  input = INPUT.clone.select { |num| num < corrupted }
  input.each_index { |start_index| (2...input.size).each { |n|
    preamble = input[input.size - start_index, n]
    sum = preamble.sum
    break if sum > corrupted
    return preamble.min + preamble.max if sum == corrupted
  } }
end

puts part1
puts part2
