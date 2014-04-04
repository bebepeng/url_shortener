class UrlShortener
  attr_reader :url, :url_hash

  def initialize(id, url)
    @url = url
    @url_hash = {}
    @url_hash[:old_url] = create_usable_url
    @url_hash[:id] = id.to_s
    @url_hash[:total_visits] = 0
  end

  def create_usable_url
    if /(^https:\/\/)/.match(@url) != nil
      "#{url}"
    elsif /(^http:\/\/)/.match(@url) != nil
      "#{url}"
    else
      "http://#{url}"
    end
  end

  def url_is_valid?
    url_to_check = create_usable_url
    !!(url_to_check =~ URI::DEFAULT_PARSER.regexp[:ABS_URI] && /[.][A-Za-z]{2,}/.match(@url) != nil)
  end
end