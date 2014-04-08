class UrlValidationResult
 attr_reader :validity, :error

  def initialize(validity,error)
    @validity = validity
    @error = error
  end
end