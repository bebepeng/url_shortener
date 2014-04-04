require 'spec_helper'
require 'url_shortener'

describe UrlShortener do
  it 'can generate a new url from a given url' do
    url = UrlShortener.new(1, 'www.gschool.it')
    expect(url.url_hash).to eq ({:old_url => 'http://www.gschool.it',
                                                          :id => '1',
                                                          :total_visits => 0})
  end

  it 'returns false if an invalid URL is entered into shortener' do
    url = UrlShortener.new(1, 'some string')
    expect(url.url_is_valid?).to eq false
  end

  it 'returns true if a valid URL is entered into shortener' do
    url = UrlShortener.new(1, 'http://google.com')
    expect(url.url_is_valid?).to eq true
  end
end