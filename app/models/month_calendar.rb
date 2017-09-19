module SimpleCalendar
  class MonthCalendar < SimpleCalendar::Calendar
    private
    def date_range
      week_start_day = :monday
      beginning_of_week = start_date.beginning_of_month.beginning_of_week(week_start_day)
    end
  end
end
