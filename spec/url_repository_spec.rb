require 'spec_helper'
require 'url_repository'

describe UrlRepository do
  before do
    @repository = UrlRepository.new(DB)
  end

  it 'can return the number of visits for a particular url' do
    id = @repository.insert('http://www.google.com')
    @repository.add_visit(id)
    @repository.add_visit(id)
    expect(@repository.get_visits(id)).to eq 2
  end

  it 'can recall the original url by id' do
    id = @repository.insert('http://www.google.com')
    expect(@repository.get_url(id)).to eq 'http://www.google.com'
  end

  it 'can insert a url with a vanity' do
    @repository.insert('http://www.google.com', 'something')
    expect(@repository.get_url('something')).to eq 'http://www.google.com'
  end

  it 'can check if a vanity url does not already exist' do
    expect(@repository.has_vanity?('what')).to eq false
  end

  it 'can check if a vanity url already exists' do
    @repository.insert('http://www.google.com', 'bar')
    expect(@repository.has_vanity?('bar')).to eq true
  end
end
