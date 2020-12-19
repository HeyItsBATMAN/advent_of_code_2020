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

# Part 1
root_rule = resolve_rule("0")
regex = /^#{root_rule}$/
puts MSGS.count(&.matches?(regex))

# Part 2
rules = [8, 11, 31, 42].map { |key| {key, resolve_rule(key.to_s)} }.to_h

inner = "((42)X(31))?"
r11 = "((42)X(31))"
# After testing: Recursion occurs no more than 3 times
3.times { r11 = r11.sub("X", inner) }
r11 = r11.sub("X", "").gsub("(42)", rules[42]).gsub("(31)", rules[31])

root_rule = root_rule.gsub(rules[8], rules[42] + "+").gsub(rules[11], r11)
regex = /^#{root_rule}$/
puts MSGS.count(&.matches?(regex))
