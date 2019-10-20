class JobApplicant
  include ActiveModel::Validations

  attr_accessor :email
  attr_writer :curriculum

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: 'Invalid email' }

  def self.create_for(email, curriculum)
    applicant = JobApplicant.new
    applicant.email = email
    applicant.curriculum = curriculum
    applicant
  end

  def curriculum
    return 'not specified' if @curriculum.nil? || @curriculum.empty?

    @curriculum
  end
end
