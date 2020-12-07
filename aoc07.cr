DAY  = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
BAGS = File.read_lines("#{DAY}.txt").map { |line|
  # Replace non-data with "," split at "," and remove empty strings
  # Only data will remain, first item is our parent, the rest is children
  line = line.rchop.gsub(/contain|no other|bags*/, ",").split(",").map(&.strip).reject(&.empty?)

  # Return tuple of parent bag and array of child bags
  # Child bags contain amount first, name second
  {line.shift, line.map(&.strip.split(limit: 2))}
}.to_h
TARGET = "shiny gold"

# Find if the parent is our target
# Otherwise recursively check if any of the child bags is our target
def holds_shiny(key)
  key == TARGET ? true : BAGS[key].find { |bag| holds_shiny(bag.last) }
end

# Recursively count the total amount of bags required
# Each children gets multiplied by the amount of times it gets carried by the parent
def bags_required(key) : Int32
  1 + BAGS[key].sum { |bag| bag.first.to_i * bags_required(bag.last) }
end

# Select all paths containing our target starting from any bag
# except the target bag
puts BAGS.keys.select { |bag| bag != TARGET && holds_shiny(bag) }.size

# Starting from the target bag, find the total amount of bags being carried
puts bags_required(TARGET) - 1
