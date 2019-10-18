class JobApplicant
  include ActiveModel::Validations

  attr_accessor :email
  attr_writer :curriculum, :bio

  validates :bio, length: { maximum: 500, message: 'Bio too long. Max 500 characters' }

  def self.create_for(email, curriculum, bio = '')
    applicant = JobApplicant.new
    applicant.email = email
    applicant.curriculum = curriculum
    applicant.bio = bio
    applicant
  end

  def curriculum
    return 'not specified' if @curriculum.nil? || @curriculum.empty?

    @curriculum
  end

  def bio
    return 'not specified' if @bio.empty?

    @bio
  end
end
