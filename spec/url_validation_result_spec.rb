require 'url_validation_result'

describe UrlValidationResult do
  it "tells me if it's a valid url" do
    url = UrlValidationResult.new(false, "The URL cannot be blank.")
    expect(url.validity).to eq false
  end

  it "tells me what the error is" do
    url = UrlValidationResult.new(false, "The URL cannot be blank.")
    expect(url.error).to eq "The URL cannot be blank."
  end
end