DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")
  .map(&.split).map { |line| {cmd: line.first, amnt: line.last.to_i} }

def execute_instructions(input)
  index, accumulator, visited = 0, 0, Set(Int32).new
  while true
    inst = input[index]? || return {acc: accumulator, oob: true}
    return {acc: accumulator, oob: false} if !visited.add?(index)
    accumulator += inst[:amnt] if inst[:cmd] == "acc"
    index += inst[:amnt] - 1 if inst[:cmd] == "jmp"
    index += 1
  end
end

def find_corrupted_instruction
  INPUT.each_with_index do |inst, inst_index|
    next if inst[:cmd] == "acc"
    input = INPUT.clone
    new_inst = {cmd: inst[:cmd] == "jmp" ? "nop" : "jmp"}
    input[inst_index] = input[inst_index].merge(new_inst)
    result = execute_instructions(input)
    return result[:acc] if result[:oob]
  end
end

puts execute_instructions(INPUT.clone)[:acc]
puts find_corrupted_instruction
