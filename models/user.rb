require_relative 'validation/insecure_password'

class User
  include ActiveModel::Validations

  attr_accessor :id, :name, :email, :crypted_password, :job_offers, :updated_on, :created_on

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  SPECIAL_CHARACTERS = " !\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~".freeze
  VALID_SPECIAL_CHARACTER_REGEX = /[#{SPECIAL_CHARACTERS.gsub(/./) { |char| "\\#{char}" }}]/

  validates :name, :crypted_password, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX,
                                              message: 'invalid email' }

  def initialize(data = {})
    validate_password(data[:password])
    @id = data[:id]
    @name = data[:name]
    @email = data[:email]
    @crypted_password = if data[:password].nil?
                          data[:crypted_password]
                        else
                          Crypto.encrypt(data[:password])
                        end
    @job_offers = data[:job_offers]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end

  def has_password?(password)
    Crypto.decrypt(crypted_password) == password
  end

  private

  def validate_password(password)
    return if password.nil?
    raise InvalidSizePassword if password.size < 8
    raise InvalidPasswordWithoutUpperCaseCharacter if password !~ /[A-Z]/
    raise InvalidPasswordWithoutSpecialCharacter if password !~ VALID_SPECIAL_CHARACTER_REGEX
    raise InvalidPasswordNotAlphanumeric if password !~ /[0-9]/
  end
end
