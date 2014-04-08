require 'pad_url'

describe PadUrl do

  it 'adds http to a string that does not start with http' do
    expect(PadUrl.call('google.com')).to eq "http://google.com"
  end

  it 'does not add http to a string that already starts with http' do
    expect(PadUrl.call('http://google.com')).to eq "http://google.com"
  end

  it 'does not add http to a blank string' do
    expect(PadUrl.call('')).to eq ""
  end

  it 'does not add http to string that starts with https' do
    expect(PadUrl.call('https://google.com')).to eq "https://google.com"
  end

end