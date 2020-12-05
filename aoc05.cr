DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

seats = Array(Tuple(Int32, Int32)).new
INPUT.each do |line|
  y, x = (0..127), (0..7)
  ysize, xsize = 64, 4
  line.each_char do |char|
    case char
    when 'F'
      y = y.first(ysize)
      ysize = ysize.tdiv(2)
    when 'B'
      y = y.skip(ysize)
      ysize = ysize.tdiv(2)
    when 'L'
      x = x.first(xsize)
      xsize = xsize.tdiv(2)
    when 'R'
      x = x.skip(xsize)
      xsize = xsize.tdiv(2)
    end
  end
  seats << {y.first, x.first}
end

# Part 1
puts seats.max_of { |seat| seat.first * 8 + seat.last }

# Part 2
(15..112).each { |y| (0..7).each { |x|
  res = seats.find { |seat| seat == {y, x} }
  if !res
    puts y * 8 + x
    exit
  end
} }
