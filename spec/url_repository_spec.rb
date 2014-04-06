require 'spec_helper'
require 'url_repository'

describe UrlRepository do
  before do
    URL_DATABASE.create_table! :urls do
      primary_key :id
      String :original_url
      Integer :visits, :default => 0
    end
    url_table = URL_DATABASE[:urls]
    @repository = UrlRepository.new(url_table)
  end

  it 'can return the number of visits for a particular url' do
    @repository.insert('http://www.google.com')
    @repository.add_visit(1)
    @repository.add_visit(1)
    expect(@repository.get_visits(1)).to eq 2
  end

  it 'can recall the original url by id' do
    id = @repository.insert('http://www.google.com')
    expect(@repository.get_url(id)).to eq 'http://www.google.com'
  end
end
