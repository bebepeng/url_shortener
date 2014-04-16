require 'shortener_constraints'
require 'url'
require 'url_repository'
require 'spec_helper'

describe ShortenerConstraints do
  before do
    DB[:urls].delete
  end

  it 'is valid if both the url and vanity are valid and no errors' do
    sc = ShortenerConstraints.new(Url.new('google.com'), Vanity.new('hello'), UrlRepository.new(DB))
    expect(sc.valid?).to be_true
    expect(sc.errors).to eq [nil , nil]
  end
  it 'is invalid if the url is valid but the vanity is not' do
    sc = ShortenerConstraints.new(Url.new('google.com'), Vanity.new('fuck'), UrlRepository.new(DB))
    expect(sc.valid?).to be_false
    expect(sc.errors).to eq [nil, 'No Profanity Please.']
  end
  it 'is invalid if the vanity is valid but the url is not' do
    sc = ShortenerConstraints.new(Url.new(''), Vanity.new('hello'), UrlRepository.new(DB))
    expect(sc.valid?).to be_false
    expect(sc.errors).to eq ['The URL cannot be blank', nil]
  end
  it 'saves the url and vanity to the table if the sc is valid' do
    sc = ShortenerConstraints.new(Url.new('google.com'), Vanity.new(''), UrlRepository.new(DB))
    expect(sc.save).to be_a String
  end
  it 'does not save the url and vanity to the table if the sc is invalid' do
    sc = ShortenerConstraints.new(Url.new('blah'), Vanity.new(''), UrlRepository.new(DB))
    expect(sc.save).to be_nil
  end
end