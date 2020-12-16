DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

enum ParseMode
  Other
  YourTicket
  NearbyTickets
end

mode = ParseMode::Other
your_ticket = Array(UInt64).new
nearby_tickets = [] of Array(Int32)
rules = Hash(String, Array(Range(Int32, Int32))).new

INPUT.each do |line|
  next if line.empty?
  if line.includes? "nearby tickets"
    mode = ParseMode::NearbyTickets
    next
  elsif line.includes? "your ticket"
    mode = ParseMode::YourTicket
    next
  end

  case mode
  when ParseMode::YourTicket    then your_ticket = line.split(",").map(&.to_u64)
  when ParseMode::NearbyTickets then nearby_tickets << line.split(",").map(&.to_i)
  when ParseMode::Other
    rule_name, ranges = line.split(": ")
    rules[rule_name] = ranges.split("or").map(&.strip.split("-").map(&.to_i))
      .map { |r| (r.first..r.last) }
  end
end

# Part 1
error_rate = 0
nearby_tickets = nearby_tickets.select { |ticket|
  invalid = ticket.reject { |num| rules.values.find { |ranges|
    ranges.find { |range| range.covers?(num) }
  } }
  error_rate += invalid.sum
  invalid.empty?
}
puts error_rate

# Part 2
rule_positions = Hash(String, Array(Int32)).new
nearby_tickets.first.size.times do |i|
  rules.each do |rule, ranges|
    rule_covered = true # by each ticket
    nearby_tickets.each do |ticket|
      rule_covered = ranges.any? { |range| range.covers?(ticket[i]) }
      break if !rule_covered
    end

    next if !rule_covered
    rule_positions[rule] = Array(Int32).new if !rule_positions[rule]?
    rule_positions[rule] << i
  end
end

until rule_positions.values.all? { |pos| pos.size == 1 }
  correct = rule_positions.select { |_, pos| pos.size == 1 }.keys
  used = rule_positions.select { |_, pos| pos.size == 1 }.values.flatten

  (rule_positions.keys - correct).each do |incorrect_rule|
    rule_positions[incorrect_rule] = rule_positions[incorrect_rule] - used
  end
end

departure_indexes = rule_positions.select { |rule, _| rule.includes?("departure") }.values.flatten
puts departure_indexes.map { |index| your_ticket[index] }.product
