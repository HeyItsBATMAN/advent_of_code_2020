DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt").map { |l| {dir: l[0], amnt: l[1..].to_i} }

def part1(y = 0, x = 0, rot = 90)
  INPUT.each do |inst|
    dir, amnt = inst[:dir], inst[:amnt]
    case dir
    when 'F'
      case rot
      when   0 then y -= amnt
      when  90 then x += amnt
      when 180 then y += amnt
      when 270 then x -= amnt
      end
    when 'N' then y -= amnt
    when 'S' then y += amnt
    when 'E' then x += amnt
    when 'W' then x -= amnt
    when 'L' then rot = (rot - amnt) % 360
    when 'R' then rot = (rot + amnt) % 360
    end
  end
  y.abs + x.abs
end

def part2(y = 0, x = 0, wy = -1, wx = 10)
  INPUT.each do |inst|
    dir, amnt = inst[:dir], inst[:amnt]
    case dir
    when 'F'
      x += wx * amnt
      y += wy * amnt
    when 'N' then wy -= amnt
    when 'S' then wy += amnt
    when 'E' then wx += amnt
    when 'W' then wx -= amnt
    when 'L' then amnt.tdiv(90).times { wy, wx = [wx * -1, wy] }
    when 'R' then amnt.tdiv(90).times { wy, wx = [wx, wy * -1] }
    end
  end
  y.abs + x.abs
end

puts part1
puts part2
