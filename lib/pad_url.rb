PadUrl = ->(url) do
  if url.empty?
    ""
  elsif /(^http:\/\/)/.match(url) != nil || /(^https:\/\/)/.match(url) != nil
    url
  else
    "http://#{url}"
  end
end