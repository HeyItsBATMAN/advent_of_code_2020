DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

def solve(statement, pref_add = false)
  tokens = statement.tr("()", "").split
  until tokens.size < 3
    add_index = tokens.index("+")
    range = pref_add && add_index ? (add_index - 1..add_index + 1) : (0..2)
    grp = tokens.delete_at(range)
    op, nums = grp[1][0], [grp[0], grp[2]].map(&.to_u64)
    sum = op == '+' ? nums.sum : nums.product
    tokens.insert(pref_add && add_index ? add_index - 1 : 0, sum.to_s)
  end
  tokens.first.to_u64
end

def find_matching(line, offset = 0, pref_add = false)
  opening = line.index("(", offset)
  closing = line.index(")", offset)
  return "" if !opening || !closing
  next_opening = line.index("(", opening + 1)
  if next_opening && next_opening < closing
    return find_matching(line, opening + 1, pref_add)
  else
    statement = line[opening..closing]
    result = solve(line[opening..closing], pref_add)
    return line.sub(statement, result)
  end
end

def part1
  INPUT.sum(0_u64) { |line|
    while line.index("(")
      line = find_matching(line)
    end
    solve(line)
  }
end

def part2
  INPUT.sum(0_u64) { |line|
    while line.index("(")
      line = find_matching(line, pref_add: true)
    end
    solve(line, pref_add: true)
  }
end

puts part1
puts part2
