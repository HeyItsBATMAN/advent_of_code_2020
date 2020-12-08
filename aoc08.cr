DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

def solve(input, wait_for_termination = false)
  input
  index = 0
  accumulator = 0

  visited = Set(Int32).new

  while true
    line = input[index]?

    if !line
      return accumulator if wait_for_termination
      break
    end
    break if visited.includes? index
    visited << index

    cmd, amnt = line.split
    amnt = amnt.to_i

    case cmd
    when "acc"
      accumulator += amnt
      index += 1
    when "jmp"
      index += amnt
    when "nop"
      index += 1
    end
  end
  wait_for_termination ? nil : accumulator
end

def part2
  INPUT.each_with_index { |line, line_index|
    input = INPUT.clone
    cmd = line.split.first

    case cmd
    when "nop"
      input[line_index] = line.sub("nop", "jmp")
    when "jmp"
      input[line_index] = line.sub("jmp", "nop")
    else
      next
    end

    if result = solve(input, true)
      return result
    end
  }
end

puts solve(INPUT.clone)
puts part2
