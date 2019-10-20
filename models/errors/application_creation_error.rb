class ApplicationCreationExceptions < RuntimeError
end

class InvalidRemunerationRangeError < ApplicationCreationExceptions
  def initialize(message = 'Invalid Range')
    super(message)
  end
end

class InvalidEmailApplicantError < ApplicationCreationExceptions
  def initialize(message = 'Invalid email')
    super(message)
  end
end
