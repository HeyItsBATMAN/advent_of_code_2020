DAY    = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT  = File.read_lines("#{DAY}.txt").map(&.split(",").map(&.to_i)).flatten
MEMORY = Hash(Int32, Array(Int32)).new

turn = 1
queue = INPUT.clone
until queue.empty?
  num = queue.shift

  grp = MEMORY[num]?
  if grp && grp.size > 0
    grp = grp.last(2)
    num = grp.last - grp.first
  end

  mem = MEMORY[num]?
  mem << turn if mem
  MEMORY[num] = [turn] if !mem

  queue << num if queue.size == 0

  if turn == 2020
    puts "Turn:#{turn}\tSpoken:#{num}"
  elsif turn == 30000000
    puts "Turn:#{turn}\tSpoken:#{num}"
    break
  end

  turn += 1
end
