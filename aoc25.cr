DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map(&.to_u64)

def transform(value, subject_number)
  (value * subject_number) % 20201227
end

card, door = INPUT.map do |public_key|
  value, loop_size = 1_u64, 0
  until value == public_key
    loop_size += 1
    value = transform(value, 7)
  end
  {value, loop_size}
end

card_key = card.first
(door.last - 1).times { card_key = transform(card_key, card.first) }
door_key = door.first
(card.last - 1).times { door_key = transform(door_key, door.first) }

puts "#{card_key} <=> #{door_key}"
