module StoriesHelper
  def check_http(link)
    link.starts_with?("http://") ? link : "http://#{link}"
  end
end
