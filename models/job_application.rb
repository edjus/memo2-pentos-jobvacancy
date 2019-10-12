class JobApplication
  attr_accessor :applicant_email
  attr_writer :applicant_curriculum
  attr_accessor :job_offer

  def self.create_for(email, curriculum, offer)
    app = JobApplication.new
    app.applicant_email = email
    app.applicant_curriculum = curriculum
    app.job_offer = offer
    app
  end

  def applicant_curriculum
    return 'not specified' if @applicant_curriculum.nil? || @applicant_curriculum.empty?

    @applicant_curriculum
  end

  def process
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end
end
