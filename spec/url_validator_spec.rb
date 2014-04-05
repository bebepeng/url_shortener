require 'spec_helper'
require 'url_validator'

describe UrlValidator do

  it 'returns false if an invalid URL is entered into shortener' do
    url = UrlValidator.new('some string')
    expect(url.url_is_valid?).to eq false
  end

  it 'returns true if a valid URL is entered into shortener' do
    url = UrlValidator.new('http://google.com')
    expect(url.url_is_valid?).to eq true
  end
end