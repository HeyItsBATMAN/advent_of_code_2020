require "http/client"

time = Time.local Time::Location.load("Europe/Berlin")
year = time.year
day = time.day

def pad_zero(value : String | Int)
  "00#{value}".split("").last(2).join("")
end

headers = HTTP::Headers{"cookie" => "session=#{ENV["AOC_SESSION"]}"}
while true
  response = HTTP::Client.get \
    "https://adventofcode.com/#{year}/day/#{day}/input",
    headers: headers
  if response.status_code == 200
    filename = "aoc#{pad_zero(day)}.txt"
    File.write(filename, response.body)
    puts "Response written to #{filename}. Good luck!"
    exit
  else
    puts "Failed getting input..."
    puts response.status_code
  end
  sleep 15
end
