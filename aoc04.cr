DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read_lines("#{DAY}.txt")

REQS       = ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"]
EYE_COLORS = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

def is_valid(passport : Hash(String, String))
  !REQS.find { |key| !passport[key]? }
end

def is_strict_valid(passport : Hash(String, String))
  count = passport.map { |key, value|
    case key
    when "byr" then (1920..2002).covers? value.to_i
    when "iyr" then (2010..2020).covers? value.to_i
    when "eyr" then (2020..2030).covers? value.to_i
    when "hgt"
      m = value.match(/^(\d+)(cm|in)$/)
      return false if !m
      h, u = m[1].to_i, m[2]
      u == "cm" ? (150..193).covers?(h) : (59..76).covers?(h)
    when "hcl" then !value.match(/^#([0-9a-f]{6})$/).nil?
    when "ecl" then EYE_COLORS.includes?(value)
    when "pid" then !value.match(/^([0-9]{9})$/).nil?
    when "cid" then true
    else            false
    end
  }.count(true)

  passport["cid"]? ? count == 8 : count == 7
end

valid = 0
strict = 0
passport = Hash(String, String).new
INPUT.each_with_index do |line, line_index|
  if line.empty? || line_index + 1 >= INPUT.size
    valid += 1 if is_valid(passport)
    strict += 1 if is_strict_valid(passport)
    passport.clear
  else
    line.split.each do |s|
      key, value = s.split(":") #
      passport[key] = value
    end
  end
end

puts valid
puts strict
