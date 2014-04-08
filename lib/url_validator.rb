require './lib/url_validation_result'

class UrlValidator

  def initialize(url)
    @url = url
  end

  def validate
    case
      when @url.empty?
        UrlValidationResult.new(false, "The URL cannot be blank.")
      when !valid?
        UrlValidationResult.new(false, "The text you entered is not a valid URL.")
      else
        UrlValidationResult.new(true, "")
    end
  end

  private

  def valid?
    (@url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI] && /[.][A-Za-z]{2,}/.match(@url) != nil)
  end
end