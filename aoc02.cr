require "benchmark"

DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")
total = Benchmark.realtime do
  silver, gold = 0, 0
  INPUT.each do |line|
    low, high, letter, password = line.sub("-", " ").split
    low, high, letter = low.to_i, high.to_i, letter[0]
    count = password.count letter

    silver += 1 if count >= low && count <= high
    gold += 1 if (password[low - 1] == letter) ^ (password[high - 1] == letter)
  end
  puts "Silver: #{silver}\tGold: #{gold}"
end
puts "Time:#{total.total_milliseconds}ms"
