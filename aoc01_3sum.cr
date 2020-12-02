require "benchmark"

TOKEN = 2020
DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
threesumtime = Benchmark.realtime do
  input = File.read_lines("#{DAY}.txt").map(&.to_i).sort
  silver = false
  gold = false
  (0..input.size - 2).each do |i|
    a = input[i]
    start = i + 1
    stop = input.size - 1
    break if silver && gold
    while start < stop
      b = input[start]
      c = input[stop]
      break if silver && gold
      sum = a + b + c
      if !silver
        if sum - a == TOKEN
          puts b * c
          silver = true
        elsif sum - b == TOKEN
          puts a * c
          silver = true
        elsif sum - c == TOKEN
          puts a * b
          silver = true
        end
      end
      if sum == TOKEN
        puts a * b * c
        gold = true
      elsif sum > TOKEN
        stop -= 1
      else
        start += 1
      end
    end
  end
end
puts "3SUM\t#{threesumtime.total_milliseconds}ms"
