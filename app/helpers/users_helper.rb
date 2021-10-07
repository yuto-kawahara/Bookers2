module UsersHelper
  
  def count_set
    @today = post_count((Date.today).in_time_zone.all_day)
    @yesterday = post_count((Date.today - 1).in_time_zone.all_day)
    @this = post_count(1.week.ago.beginning_of_day..Time.zone.now.end_of_day)
    @last = post_count(2.week.ago.beginning_of_day..(Date.today - 7).end_of_day)
    @dod = day_over_day_changes(@today,@yesterday)
    @wow = week_over_week_changes(@this,@last)
  end

  def post_count(date)
    return current_user.books.where(created_at: date).count
  end
  
  def day_over_day_changes(today,yesterday)
    if yesterday != 0
      return number_to_percentage((today / yesterday.to_f) * 100, precision:0)
    else
      return number_to_percentage(0, precision:0)
    end
  end
  def week_over_week_changes(this, last)
    if last != 0
      return number_to_percentage((this / last.to_f) * 100, precision:0)
    else
      return number_to_percentage(0, precision:0)
    end
  end

  def book_post_7days
    @date = []
    @count = []
    for num in 0..6 do
      day = num.day.ago.all_day
      if day == Date.today.all_day
        d = "今日"
      else
        d = num.to_s + "日前"
      end
      result = post_count(day)
      @date.push(d)
      @count.push(result)
    end
  end
end
