class UrlValidator
  attr_reader :error

  def initialize(url)
    @url = url
    @error = ""
  end

  def url_is_valid?
    if @url.empty?
      @error = "The URL cannot be blank."
      false
    end

    if !@url.empty?
      create_usable_url
      unless !!(@url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI] && /[.][A-Za-z]{2,}/.match(@url) != nil)
        @error = "The text you entered is not a valid URL."
        false
      else
        true
      end
    end
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