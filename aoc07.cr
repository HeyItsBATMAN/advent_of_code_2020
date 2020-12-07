DAY  = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
BAGS = File.read_lines("#{DAY}.txt").map { |line|
  line = line
    .gsub(/bags*/, "").sub("contain", ",").sub(".", ",").sub("no other", ",")
    .split(",").map(&.strip).reject(&.empty?)
  bag_name = line.shift

  contained_bags = line.map { |bag|
    number, name = bag.strip.split limit: 2
    {amount: number.to_i, name: name}
  }

  {bag_name, contained_bags}
}.to_h

def holds_shiny(key : String)
  return true if key == "shiny gold"
  current = BAGS[key]?
  current.nil? ? false : !current.find { |bag| holds_shiny(bag[:name]) }.nil?
end

def bags_required(key : String)
  current = BAGS[key]?
  current.nil? ? 0 : 1 + current.sum { |bag| bag[:amount] * bags_required(bag[:name]) }
end

puts BAGS.keys.select { |bag| bag != "shiny gold" && holds_shiny(bag) }.size
puts bags_required("shiny gold") - 1
