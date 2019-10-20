class EmailAlreadyInUseError < RuntimeError
  def initialize(message = 'Sorry, there is already an account for this email')
    super(message)
  end
end
