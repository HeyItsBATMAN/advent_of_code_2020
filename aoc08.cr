DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

def execute_instructions(input, wait_for_termination = false)
  index, accumulator, visited = 0, 0, Set(Int32).new
  while true
    line = input[index]?
    return accumulator if !line
    break accumulator if !visited.add?(index)

    cmd, amnt = line.split
    amnt = amnt.to_i

    case cmd
    when "acc"
      accumulator += amnt
      index += 1
    when "jmp" then index += amnt
    when "nop" then index += 1
    end
  end
  wait_for_termination ? nil : accumulator
end

def find_corrupted_instruction
  INPUT.each_with_index do |line, line_index|
    input = INPUT.clone
    cmd = line.split.first

    case cmd
    when "nop" then input[line_index] = line.sub("nop", "jmp")
    when "jmp" then input[line_index] = line.sub("jmp", "nop")
    else            next
    end

    if result = execute_instructions(input, true)
      return result
    end
  end
end

puts execute_instructions(INPUT.clone)
puts find_corrupted_instruction
