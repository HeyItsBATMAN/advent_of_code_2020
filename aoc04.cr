DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read("#{DAY}.txt")
  .split("\n\n")                 # seperate by passport
  .map(&.split.flatten)          # make even
  .map(&.map(&.split(":")).to_h) # as hash

REQS       = ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"]
EYE_COLORS = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

alias Passport = Hash(String, String)

def is_valid(passport : Passport)
  !REQS.find { |key| !passport[key]? }
end

def is_strict_valid(passport : Passport)
  7 == passport.map { |key, value|
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
    when "pid" then value.to_i? && value.size == 9
    when "cid" then false
    else            false
    end
  }.count(true)
end

valid = INPUT.select(->is_valid(Passport))
strict = valid.select(->is_strict_valid(Passport))

puts valid.size
puts strict.size
