require 'spec_helper'
require './lib/vanity'

describe Vanity do
  it "finds a well formateed vanity to be valid with no errors" do
    vanity = Vanity.new('foo')
    expect(vanity.error).to be_nil
    expect(vanity.valid?).to be_true
  end

  it "finds a well blank vanity to be valid with no errors" do
    vanity = Vanity.new('')
    expect(vanity.error).to be_nil
    expect(vanity.valid?).to be_true
  end

  it "finds a vanity more than 13 charactes long to be invalid with errors" do
    vanity = Vanity.new('sooooooooolllooonnnngggg')
    expect(vanity.error).to eq 'Vanity URLs must be under 13 characters'
    expect(vanity.valid?).to be_false
  end

  it "finds a vanity with profanity to be invalid with errors" do
    vanity = Vanity.new('shit')
    expect(vanity.error).to eq 'No Profanity Please.'
    expect(vanity.valid?).to be_false
  end

  it "finds a vanity with symbols and numbers to be invalid with errors" do
    vanity = Vanity.new('dr34m!')
    expect(vanity.error).to eq 'Letters Only'
    expect(vanity.valid?).to be_false
  end
end