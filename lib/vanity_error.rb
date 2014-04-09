require 'yaml'
require 'obscenity'

class VanityError
  def self.get_error(vanity)
    if Obscenity.profane?(vanity)
      'No Profanity Please.'
    elsif vanity.length > 12
      'Vanity URLs must be under 13 characters'
    else
      ''
    end
  end
end