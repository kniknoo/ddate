module Ddate
  VERSION = "0.1.0"

  # The DDate is the current day in the Discordian Calendar. A week is comprised of
  # five days. A months is comprised of 73 Days, and there are five in every year.
  # The Gregorian "Leap Day" is represented by St. Tib's Day. It is treated as a non-
  # existant day so that every year technically has 365 Days. The Year always starts
  # on a SweetMorn because 365 % 5 = 0. There is a Holiday on the 5th and 50th of
  # each month. By default, #new will provide a Time.local instance but an arbitrary
  # date can be converted by providing *Time.new(YYYY MM DD)*
  struct DDate
    @day_of_year = 0

    MONTHS = ["Chaos", "Discord", "Confusion", "Bureaucracy", "The Aftermath"]

    DAYS = ["Sweetmorn", "Boomtime", "Pungenday", "Prickle-Prickle", "Setting Orange"]

    HOLIDAYS = {
        5 => "Mungday",
       50 => "Chaoflux",
       78 => "Mojoday",
      123 => "Discoflux",
      151 => "Syaday",
      196 => "Confuflux",
      224 => "Zaraday",
      269 => "Bureflux",
      297 => "Maladay",
      342 => "Afflux",
    }

    def initialize(@time = Time.local)
      @day_of_year = day_of_year
    end

    # Determines if the year is a St Tib's Year. Returns a Bool.
    def tibs_year?
      @time.year % 4 == 0 && @time.year % 100 != 0 || @time.year % 400 == 0
    end

    # Determines if the day is St Tib's Day. Returns a Bool.
    def tibs_day?
      tibs_year? && @time.day_of_year == 60
    end

    # Determines the day of the year. If it is past St. Tib's Day, the
    # day of the year is one behind the Gregorian equivalent.
    def day_of_year
      tibs_year? && @time.day_of_year > 60 ? @time.day_of_year - 1 : @time.day_of_year
    end

    # Returns the day of the week
    def day_of_week
      DAYS[(@day_of_year - 1) % 5]
    end

    # Returns the Month
    def month
      MONTHS[@day_of_year / 73]
    end

    # Returns the day of the Month
    def day_of_month
      @day_of_year % 73 == 0 ? 73 : @day_of_year % 73
    end

    # Returns the ordinal suffix of the day of the Month
    def ordinal
      return "th" if (11..13) === day_of_month % 100
      case day_of_month % 10
      when 1 then "st"
      when 2 then "nd"
      when 3 then "rd"
      else        "th"
      end
    end

    # Returns the year
    def year
      @time.year + 1166
    end
  end
end
