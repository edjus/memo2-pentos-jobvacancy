class JobApplicant
  include ActiveModel::Validations

  attr_accessor :email
  attr_writer :curriculum

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
