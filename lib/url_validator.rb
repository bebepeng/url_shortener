class UrlValidator

  def initialize(url)
    @url = url
  end

  def url_is_valid?
    create_usable_url
    !!(@url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI] && /[.][A-Za-z]{2,}/.match(@url) != nil)
  end

  def create_usable_url
    if /(^https:\/\/)/.match(@url) != nil
      "#{@url}"
    elsif /(^http:\/\/)/.match(@url) != nil
      "#{@url}"
    else
      @url = "http://#{@url}"
    end
    @url
  end
end