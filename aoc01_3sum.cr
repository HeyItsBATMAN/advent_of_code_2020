TOKEN = 2020
DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.to_i).sort

silver, gold = false, false
(0..INPUT.size - 2).each do |i|
  a = INPUT[i]
  start = i + 1
  stop = INPUT.size - 1
  break if silver && gold
  while start < stop
    b = INPUT[start]
    c = INPUT[stop]
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
