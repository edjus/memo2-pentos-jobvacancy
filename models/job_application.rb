class JobApplication
  include ActiveModel::Validations

  attr_accessor :applicant, :remuneration
  attr_accessor :job_offer, :id, :updated_on, :created_on
  attr_writer :applicant_bio

  validates :applicant, :job_offer, presence: true
  validates :applicant_bio, length: { maximum: 500, message: 'Bio too long. Max 500 characters' }

  def self.create_for(applicant, offer, remuneration_range, applicant_bio = '')
    app = JobApplication.new
    app.applicant = applicant
    app.job_offer = offer
    app.remuneration = remuneration_range
    app.applicant_bio = applicant_bio
    app
  end

  def applicant_bio
    return 'not specified' if @applicant_bio.nil? || @applicant_bio.empty?

    @applicant_bio
  end

  def process
    JobVacancy::App.deliver(:application_notification, :contact_info_email, self)
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end
end
