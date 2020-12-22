DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read("#{DAY}.txt").split("\n\n").map(&.split("\n").reject(&.empty?).skip(1).map(&.to_i))

def part1
  input = INPUT.clone
  p1, p2 = input
  until p1.empty? || p2.empty?
    p1card = p1.shift
    p2card = p2.shift
    if p1card > p2card
      p1 << p1card
      p1 << p2card
    elsif p2card > p1card
      p2 << p2card
      p2 << p1card
    end
  end
  arr = p1 + p2
  arr.map_with_index { |num, i| (arr.size - i) * num }.sum
end

def sub_game(p1, p2)
  hist = Set(Tuple(Array(Int32), Array(Int32))).new
  until p1.empty? || p2.empty?
    return [[1], [] of Int32] if !hist.add?({p1, p2})
    p1card = p1.shift
    p2card = p2.shift
    if p1.size >= p1card && p2.size >= p2card
      subp1, subp2 = sub_game(p1.first(p1card), p2.first(p2card))
      if subp2.empty?
        p1 << p1card
        p1 << p2card
      elsif subp1.empty?
        p2 << p2card
        p2 << p1card
      end
    elsif p1card > p2card
      p1 << p1card
      p1 << p2card
    elsif p2card > p1card
      p2 << p2card
      p2 << p1card
    end
  end
  [p1, p2]
end

def part2
  input = INPUT.clone
  p1, p2 = input
  p1, p2 = sub_game(p1, p2)
  arr = p1 + p2
  arr.map_with_index { |num, i| (arr.size - i) * num }.sum
end

puts part1
puts part2
