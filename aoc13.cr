DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

DEPARTURE = INPUT.first.to_i
LINES     = INPUT.last.split(",")
  .reject { |val| val == "x" }
  .map { |val| {val.to_u64, INPUT.last.split(",").index(val).not_nil!} }.to_h

def part1(lines = LINES.keys)
  first = lines.map { |id| {DEPARTURE - (DEPARTURE % id) + id, id} }.to_h.min
  (first.first - DEPARTURE) * first.last
end

def part2(lines = LINES.clone)
  step = lines.first.first
  timestamp = step
  lines.keys.each do |id|
    until (timestamp + lines[id]) % id == 0
      timestamp += step
    end
    step = step.lcm(id)
  end
  timestamp
end

puts part1
puts part2
