DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

EARLY_TIME = INPUT.first.to_i
LINES      = INPUT.last.split(",")
  .reject { |val| val == "x" }
  .map { |val| {val.to_u64, val.to_u64} }.to_h

def part1
  lines = INPUT.last.split(",")
    .reject { |val| val == "x" }
    .map { |val| {val.to_u64, val.to_u64} }.to_h
  until lines.all? { |id, val| val > EARLY_TIME }
    lines.keys.each do |id|
      lines[id] += id if lines[id] < EARLY_TIME
    end
  end
  if bus = lines.min_by { |id, val| val }
    id, minutes = bus.first, bus.last
    return (minutes - EARLY_TIME) * id
  end
end

def part2
  split = INPUT.last.split(",")

  lines = INPUT.last.split(",")
    .reject { |val| val == "x" }
    .map { |val| {val.to_u64, split.index(val).not_nil!} }.to_h
  ids = lines.keys

  step = [lines.first.first]
  lcm = ->{
    temp = step.clone
    num = 1_u64
    until temp.empty?
      num = num.lcm(temp.pop)
    end
    num
  }
  timestamp = lcm.call
  until ids.empty?
    id = ids.shift

    until (timestamp + lines[id]) % id == 0
      timestamp += lcm.call
    end

    step << id
    step.uniq!
  end
  timestamp
end

puts part1
puts part2
