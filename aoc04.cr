DAY   = PROGRAM_NAME.match(/aoc\d{2}/).not_nil![0]
INPUT = File.read("#{DAY}.txt")
  .split("\n\n")                               # seperate by passport
  .map(&.split.flatten.map(&.split(":")).to_h) # as hash

REQS       = ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"]
EYE_COLORS = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

alias Passport = Hash(String, String)

def is_valid(passport : Passport)
  !REQS.find { |key| !passport[key]? }
end

def is_strict_valid(passport : Passport)
  passport.find { |key, value|
    case key
    when "byr" then !("1920".."2002").covers? value
    when "iyr" then !("2010".."2020").covers? value
    when "eyr" then !("2020".."2030").covers? value
    when "hgt"
      m = value.match(/^(\d+)(cm|in)$/)
      return false if !m
      m[2] == "cm" ? !("150".."193").covers?(m[1]) : !("59".."76").covers?(m[1])
    when "hcl" then value.match(/^#([0-9a-f]{6})$/).nil?
    when "ecl" then !EYE_COLORS.includes?(value)
    when "pid" then !value.to_i? || value.size != 9
    else            false
    end
  }.nil?
end

valid = INPUT.select(->is_valid(Passport))
strict = valid.select(->is_strict_valid(Passport))

puts valid.size
puts strict.size
