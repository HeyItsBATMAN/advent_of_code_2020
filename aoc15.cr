DAY    = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT  = File.read_lines("#{DAY}.txt").map(&.split(",").map(&.to_i)).flatten
MEMORY = Hash(Int32, Array(Int32)).new

turn = 1
queue = INPUT.clone
until queue.empty?
  num = queue.shift?
  break if !num

  MEMORY[num] = Array(Int32).new if !MEMORY[num]?
  if MEMORY[num].size == 1 # first time repeated
    num = 0
  elsif MEMORY[num].size >= 2 # multiple times repeated
    grp = MEMORY[num].last(2)
    num = grp.last - grp.first
  end

  MEMORY[num] = Array(Int32).new if !MEMORY[num]?
  MEMORY[num] << turn
  queue << num if queue.size == 0

  print "Turn:#{turn}\r"

  if turn == 2020
    puts
    puts "Turn:#{turn}\tSpoken:#{num}"
    break
  elsif turn == 30000000
    puts
    puts "Turn:#{turn}\tSpoken:#{num}"
    break
  end

  # puts "Turn:#{turn}\tSpoken:#{num}"
  # a = gets
  turn += 1
end
