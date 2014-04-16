require 'url'

describe Url do
  it 'returns a padded url' do
    url = Url.new('yay')
    expect(url.padded).to eq 'http://yay'
  end

  it 'does not pad an empty string' do
    url = Url.new('')
    expect(url.padded).to eq ''
  end

  it 'tells me if a url is valid with no errors' do
    url = Url.new('google.com')
    expect(url.valid?).to be_true
    expect(url.error).to be_nil
  end

  it 'tells me if a url is invalid with an error' do
    url = Url.new('yay')
    expect(url.valid?).to be_false
    expect(url.error).to eq 'The text you entered is not a valid URL.'
  end

  it 'tells me a blank url is invalid with an error' do
    url = Url.new('')
    expect(url.valid?).to be_false
    expect(url.error).to eq 'The URL cannot be blank'
  end
end