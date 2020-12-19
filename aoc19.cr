DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

RULES = Hash(String, Array(String)).new
MSGS  = Array(String).new

at_rules = true
INPUT.each do |line|
  if line.empty?
    at_rules = !at_rules
    next
  end

  if at_rules
    key, value = line.tr("\\\"", "").split(": ")
    RULES[key] = value.split(" | ")
  else
    MSGS << line
  end
end

def resolve_rule(key)
  return key if key == "a" || key == "b"
  rule = RULES[key]
  rule = rule.map { |sub|
    sub.split(" ").map { |slot|
      resolve_rule(slot)
    }.join
  }.join("|")
  rule.size > 1 ? "(#{rule})" : rule
end

# Part 1
root_rule = resolve_rule("0")
regex = /^#{root_rule}$/
puts MSGS.count { |line| line.matches?(regex) }

# Part 2
rule8 = resolve_rule("8")
rule11 = resolve_rule("11")
rule31 = resolve_rule("31")
rule42 = resolve_rule("42") + "+"
root_rule = root_rule.gsub(rule8, rule42)

inner = "((42)X(31))?"
outer = "((42)X(31))"
new_rule11 = outer
13.times do
  new_rule11 = new_rule11.sub("X", inner)
end
new_rule11 = new_rule11.sub("X", "")
new_rule11 = new_rule11.gsub("(42)", rule42)
new_rule11 = new_rule11.gsub("(31)", rule31)

root_rule = root_rule.gsub(rule11, new_rule11)
regex = /^#{root_rule}$/
puts MSGS.count { |line| line.matches?(regex) }
