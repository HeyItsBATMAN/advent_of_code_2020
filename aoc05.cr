DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")
SEATS = Set(Int32).new initial_capacity: INPUT.size

max_seat = 0
INPUT.each { |line|
  seat_id = line.tr("BRFL", "1100").to_i(2)
  max_seat = seat_id if seat_id > max_seat
  SEATS << seat_id
}

# Part 1
puts max_seat

# Part 2
puts (0..max_seat).find { |val|
  next if SEATS.includes? val
  SEATS.includes?(val + 1) && SEATS.includes?(val - 1)
}
