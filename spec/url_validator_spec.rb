require 'spec_helper'
require 'url_validator'

describe UrlValidator do

  it 'returns false if an invalid URL is entered into shortener' do
    url = UrlValidator.new('some string')
    expect(url.validate.validity).to eq false
  end

  it 'returns true if a valid URL is entered into shortener' do
    url = UrlValidator.new('http://google.com')
    expect(url.validate.validity).to eq true
  end

  it 'returns an empty string for the error of a valid url' do
    url = UrlValidator.new('http://google.com')
    expect(url.validate.error).to eq ''
  end

  it 'returns an error message for invalid urls' do
    url = UrlValidator.new('http://google')
    expect(url.validate.error).to eq 'The text you entered is not a valid URL.'
  end

  it 'returns an error message for blank urls' do
    url = UrlValidator.new('')
    expect(url.validate.error).to eq 'The URL cannot be blank.'
  end
end