DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

BAGS = INPUT.map { |line|
  line = line
    .gsub("bags contain", ",")
    .gsub(".", ",")
    .gsub("no other bags", ",")
    .split(",")
    .map(&.strip)
    .reject(&.empty?)
  first = line.shift

  line = line
    .map(&.gsub("bags", "").gsub("bag", "").strip)
    .map { |bag|
      split = bag.split(" ")
      number = split.shift.to_i
      {number, split.join(" ")}
    }

  {first, line}
}.to_h

def holds_shiny(key : String)
  return true if key == "shiny gold"
  current = BAGS[key]?
  return false if !current
  return !current.find { |bag| holds_shiny(bag.last) }.nil?
end

def bags_required(key : String)
  current = BAGS[key]?
  return 0 if current.nil?
  return 1 + current.sum { |bag|
    mult = bag.first
    name = bag.last
    nested = mult * bags_required(name)
    nested
  }
end

def part1
  BAGS.keys.select { |bag|
    next if bag == "shiny gold"
    holds_shiny(bag)
  }.size
end

def part2
  bags_required("shiny gold") - 1
end

puts part1
puts part2
