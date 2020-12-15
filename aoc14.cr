DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")
MASK  = ["X" * 36]

def part1
  memory = Hash(UInt64, UInt64).new
  INPUT.each do |line|
    cmd, val = line.split(" = ")

    if cmd == "mask"
      MASK << val
      next
    end

    addr = cmd.match(/mem\[(\d+)\]/)
    raise "No memory address" if !addr
    addr = addr[1].to_u64

    val = val.to_i.to_s(2).rjust(36, '0')
    mask = MASK.last.chars
    applied = ("0" * 36).chars

    val.size.times do |from_right|
      char = val[val.size - 1 - from_right]
      mask_char = mask[mask.size - 1 - from_right]
      if mask_char == 'X'
        applied[mask.size - 1 - from_right] = char
      elsif mask_char != 'X'
        applied[mask.size - 1 - from_right] = mask_char
      end
    end

    memory[addr] = applied.join.to_u64(2)
  end
  memory.values.sum
end

def part2
  memory = Hash(UInt64, UInt64).new
  INPUT.each do |line|
    cmd, val = line.split(" = ")

    if cmd == "mask"
      MASK << val
      next
    end

    addr = cmd.match(/mem\[(\d+)\]/)
    raise "No memory address" if !addr
    addr = addr[1].to_u64.to_s(2).rjust(36, '0')
    mask = MASK.last.chars
    applied = ("0" * 36).chars

    addr.size.times do |from_right|
      char = addr[addr.size - 1 - from_right]
      mask_char = mask[mask.size - 1 - from_right]
      case mask_char
      when '0' then applied[mask.size - 1 - from_right] = char
      when '1' then applied[mask.size - 1 - from_right] = '1'
      when 'X' then applied[mask.size - 1 - from_right] = 'X'
      end
    end

    count = applied.count('X')
    options = ("01" * count).chars.combinations(count).uniq
    options.each do |option|
      next_addr = applied.join
      until option.empty?
        next_addr = next_addr.sub("X", option.pop)
      end
      memory[next_addr.to_u64(2)] = val.to_u64
    end
  end
  memory.values.sum
end

puts part1
puts part2
