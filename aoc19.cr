DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")
MSGS  = INPUT.reject { |line| line.includes?(":") && line.empty? }
RULES = INPUT.select(&.includes?(":")).map(&.tr("\\\"", "").split(": "))
  .map { |rule_pair| {rule_pair[0], rule_pair[1].split(" | ")} }.to_h

def resolve_rule(key)
  return key if key == "a" || key == "b"
  rule = RULES[key]
  rule = rule.map { |s| s.split.map { |si| resolve_rule(si) }.join }.join("|")
  rule.size > 1 ? "(#{rule})" : rule
end

rules = [0, 8, 11, 31, 42].map { |key| {key, resolve_rule(key.to_s)} }.to_h

# Part 1
regex = /^#{rules[0]}$/
puts MSGS.count(&.matches?(regex))

# Part 2
rule, final_rule, depth = "((42)X(31))", Regex.new(""), 0
begin # repeat until regex gets too large
  while depth += 1
    r11 = rule
    depth.times { r11 = r11.sub("X", rule + "?") }
    r11 = r11.sub("X", "").gsub("(42)", rules[42]).gsub("(31)", rules[31])
    next_rule = rules[0].gsub(rules[8], rules[42] + "+").gsub(rules[11], r11)
    final_rule = /^#{next_rule}$/
  end
rescue
end

puts MSGS.count(&.matches?(final_rule))
