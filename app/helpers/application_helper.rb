module ApplicationHelper
  def format_time(time)
    time_ago_in_words(time.localtime)
  end
  
end
