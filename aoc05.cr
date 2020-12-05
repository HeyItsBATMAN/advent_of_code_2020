DAY = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]

min, max, sum, seat_id = UInt64::MAX, 0_u64, 0_u64, 0_u64

File.read_lines("#{DAY}.txt").each { |line|
  seat_id = line.tr("BRFL", "1100").to_u64(2)
  sum += seat_id
  min = seat_id if seat_id < min
  max = seat_id if seat_id > max
}

# Part 1
puts max

# Part 2
puts (min..max).sum - sum
