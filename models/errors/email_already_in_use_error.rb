class EmailAlreadyInUseError < UserCreationExceptions
  def initialize(message = 'there is already an account for this email')
    super(message)
  end
end
