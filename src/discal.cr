require "option_parser"
require "colorize"
require "./ddate"

date = Time.local
color = false

OptionParser.parse do |parser|
  parser.banner = "Usage: discal [arguments] <date: YYYY MM DD>"
  parser.on("-c", "--color", "Prints important values in color") { color = true }
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.unknown_args { |day| date = Time.local(day[0].to_i, day[1].to_i, day[2].to_i) if day.any? && day.size == 3 }
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

# Prints a message about the day provided. If it is St Tib's Day, Prints
# a special message regarding the non-existance of the day. If the day is
# a Holiday, a celebratory message is added.
def fnord(day, color)
  if day.tibs_day?
    puts "Today is St Tib's Day. It doesn't actually exist."
  else
    puts "Today is #{day.day_of_week.colorize(:light_red).toggle(color)}, " \
         "the #{day.day_of_month.colorize(:light_green).toggle(color)}#{day.ordinal} " \
         "day of #{day.month.colorize(:light_blue).toggle(color)} " \
         "in the YOLD #{day.year.colorize(:light_magenta).toggle(color)}"
  end
  puts "Happy #{Ddate::DDate::HOLIDAYS[day.day_of_year]}!" if Ddate::DDate::HOLIDAYS.has_key?(day.day_of_year)
end

ddate = Ddate::DDate.new(date)

fnord(ddate, color)
