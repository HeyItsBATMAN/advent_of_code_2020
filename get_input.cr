require "http/client"

current_time = Time.local Time::Location.load("Europe/Berlin")
options = {"day" => current_time.day.to_s, "year" => current_time.year.to_s}
options.merge! ARGV.map(&.split("=")).to_h

def pad_zero(value : String | Int)
  "00#{value}".split("").last(2).join("")
end

def download_input(day, year)
  puts "Downloading input for day #{day} year #{year}"
  headers = HTTP::Headers{"cookie" => "session=#{ENV["AOC_SESSION"]}"}
  while true
    response = HTTP::Client.get \
      "https://adventofcode.com/#{year}/day/#{day}/input",
      headers: headers
    if response.status_code == 200
      filename = "aoc#{pad_zero(day)}.txt"
      File.write(filename, response.body)
      puts "Response written to #{filename}. Good luck!"
      break
    else
      puts "Failed getting input..."
      puts response.status_code
    end
    sleep 15
  end
end

download_input day: options["day"], year: options["year"]
