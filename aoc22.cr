DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read("#{DAY}.txt")
  .split("\n\n").map(&.split("\n").reject(&.empty?).skip(1).map(&.to_i))
CARD_AMNT = INPUT.flatten.size
alias DeckHistory = Set(Tuple(Array(Int32), Array(Int32)))

def part1
  p1, p2 = INPUT.clone
  until p1.empty? || p2.empty?
    p1card, p2card = p1.shift, p2.shift
    p1card > p2card ? p1.push(p1card, p2card) : p2.push(p2card, p1card)
  end
  (p1 + p2).map_with_index { |num, i| (CARD_AMNT - i) * num }.sum
end

def sub_game(p1, p2)
  hist = DeckHistory.new
  until p1.empty? || p2.empty?
    return [[1], [] of Int32] if !hist.add?({p1, p2})
    p1card, p2card = p1.shift, p2.shift
    if p1.size >= p1card && p2.size >= p2card
      _, subp2 = sub_game(p1.first(p1card), p2.first(p2card))
      subp2.empty? ? p1.push(p1card, p2card) : p2.push(p2card, p1card)
    else
      p1card > p2card ? p1.push(p1card, p2card) : p2.push(p2card, p1card)
    end
  end
  [p1, p2]
end

def part2
  sub_game(INPUT.first.clone, INPUT.last.clone).flatten
    .map_with_index { |num, i| (CARD_AMNT - i) * num }.sum
end

puts part1
puts part2
