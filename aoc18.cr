DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

# INPUT = "1 + (2 * 3) + (4 * (5 + 6))
# 2 * 3 + (4 * 5)
# 5 + (8 * 3 + 9 + 3 * 4 * 3)
# 5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))
# ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2
# ".lines

def solve(statement, pref_add = false)
  tokens = statement.tr("()", "").split
  until tokens.size < 3
    sum = 0_u64
    add_index = tokens.index("+")
    if pref_add && add_index
      range = add_index - 1..add_index + 1
      grp = tokens[range]
      tokens.delete_at(range)
    else
      grp = tokens.shift(3)
    end
    op = grp[1][0]
    nums = [grp[0], grp[2]].map(&.to_u64)
    case op
    when '+' then sum += nums.sum
    when '*' then sum += nums.product
    else
      puts "unkown op #{op}"
    end

    if pref_add && add_index
      tokens.insert(add_index - 1, sum.to_s)
    else
      tokens.insert(0, sum.to_s)
    end
  end
  tokens.first.to_u64
end

def find_matching(line, offset = 0, pref_add = false)
  opening = line.index("(", offset)
  return "" if !opening
  next_opening = line.index("(", opening + 1)
  closing = line.index(")", opening)
  return "" if !closing
  if next_opening && next_opening < closing
    return find_matching(line, opening + 1, pref_add)
  else
    statement = line[opening..closing]
    result = solve(line[opening..closing], pref_add)
    return line.sub(statement, result)
  end
end

def part1
  input = INPUT.clone
  total = 0_u64
  input.each do |line|
    while line.index("(")
      line = find_matching(line)
    end
    sum = solve(line)
    total += sum
  end
  total
end

def part2
  input = INPUT.clone
  total = 0_u64
  input.each do |line|
    while line.index("(")
      line = find_matching(line, pref_add: true)
    end
    sum = solve(line, pref_add: true)
    total += sum
  end
  total
end

puts part1
puts part2
