require 'vanity'

class ShortenerConstraints
  def initialize (url, vanity, repo)
    @url = url
    @vanity = vanity
    @repo = repo
  end

  def valid?
    url.valid? && !repo.has_vanity?(vanity.vanity) && vanity.valid?
  end

  def errors
    if repo.has_vanity?(vanity.vanity)
      message_vanity = 'That vanity is already taken'
    else
      message_vanity = vanity.error
    end
    [url.error, message_vanity]
  end

  def save
    if url.valid?
      repo.insert(url.padded, vanity.vanity)
    end
  end

  private
  attr_reader :url, :vanity, :repo
end