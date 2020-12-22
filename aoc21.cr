DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")
  .map(&.tr("(),", "").split(" contains ").map(&.split))

algs_map = Hash(String, Array(String)).new
all_ings = Set(String).new
INPUT.each do |line|
  ings, algs = line
  ings.each { |ing| all_ings << ing }
  algs.each do |al|
    other_ings = algs_map[al]? || ings
    algs_map[al] = other_ings & ings
  end
end
algs_map.values.each { |ings| all_ings -= ings }

# Part 1
puts INPUT.sum { |line| all_ings.sum { |ing| line.first.count(ing) } }

# Part 2
canon_danger = Hash(String, String).new
until algs_map.empty?
  algs_map.select { |_, v| v.size == 1 }.each do |al, ing|
    canon_danger[ing.first] = al
    algs_map.delete(al)
  end
  algs_map.each { |al, ing| algs_map[al] = ing - canon_danger.keys }
end
puts canon_danger.to_a.sort_by(&.last).map(&.first).join(",")
