require 'spec_helper'
require './lib/vanity_error'

describe VanityError do
  it "returns an empty error if the vanity is formatted well" do
    expect(VanityError.get_error('foo')).to eq ''
  end

  it "returns an empty error if the vanity is blank" do
    expect(VanityError.get_error('')).to eq ''
  end

  it "lets me know if the vanity is more than 13 characters long" do
    expect(VanityError.get_error('sooooooooolllooonnnngggg')).to eq 'Vanity URLs must be under 13 characters'
  end

  it "lets me know if the vanity contains a profanity" do
    expect(VanityError.get_error('shit')).to eq 'No Profanity Please.'
  end
end