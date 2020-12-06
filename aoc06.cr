DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

def part1
  input = INPUT.clone
  counter = 0
  group = Set(Char).new
  input.each do |line|
    if line.empty?
      counter += group.size
      group.clear
    else
      group += line.chars.to_set
    end
  end
  counter + group.size
end

def part2
  input = INPUT.clone
  counter = 0
  group = [] of Set(Char)
  input.each do |line|
    if line.empty?
      solution = group.reduce { |acc, val| acc & val }
      counter += solution.size
      group.clear
    else
      group << line.chars.to_set
    end
  end
  solution = group.reduce { |acc, val| acc & val }
  counter + solution.size
end

puts part1
puts part2
