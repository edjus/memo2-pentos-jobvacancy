require_relative '../errors/user_creation_exceptions.rb'

class InsecurePasswordException < UserCreationExceptions
  def initialize(message)
    super(message)
  end
end

class InvalidSizePassword < InsecurePasswordException
  def initialize(message = 'passwords must have at least 8 characters')
    super(message)
  end
end

class InvalidPasswordWithoutUpperCaseCharacter < InsecurePasswordException
  def initialize(message = 'passwords must have at least one Upper Case character')
    super(message)
  end
end

class InvalidPasswordWithoutSpecialCharacter < InsecurePasswordException
  def initialize(message = 'passwords must have at least one special character')
    super(message)
  end
end

class InvalidPasswordNotAlphanumeric < InsecurePasswordException
  def initialize(message = 'passwords must be alphanumeric')
    super(message)
  end
end
