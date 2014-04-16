require 'yaml'
require 'obscenity'

class Vanity
  def initialize(vanity)
    @vanity = vanity
  end

  def valid?
    error.nil?
  end

  def error
    if Obscenity.profane?(vanity)
      'No Profanity Please.'
    elsif vanity =~ /\d|\W/
      'Letters Only'
    elsif vanity.length > 12
      'Vanity URLs must be under 13 characters'
    end
  end

  attr_reader :vanity
end