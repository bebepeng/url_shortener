class Url
  def initialize(unpadded_url)
    @unpadded_url = unpadded_url
  end

  def valid?
    error.nil?
  end

  def error
    if padded.empty?
      "The URL cannot be blank"
    elsif !able_to_parse? || !ends_with_tld?
      "The text you entered is not a valid URL."
    end
  end

  def padded
    if %r(^https?://) === unpadded_url || unpadded_url.empty?
      unpadded_url
    else
      "http://#{unpadded_url}"
    end
  end

  private

  attr_reader :unpadded_url

  def able_to_parse?
    URI::DEFAULT_PARSER.regexp[:ABS_URI] === padded
  end

  def ends_with_tld?
    /[.][A-Za-z]{2,}/ === padded
  end
end