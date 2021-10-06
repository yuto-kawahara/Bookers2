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
    return number_to_percentage(yesterday / today, precision:0)
  end
  def week_over_week_changes(this, last)
    return number_to_percentage(last / this, precision:0)
  end

  

end
