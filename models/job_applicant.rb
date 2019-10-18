class JobApplicant
  attr_accessor :email
  attr_writer :curriculum, :bio

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
