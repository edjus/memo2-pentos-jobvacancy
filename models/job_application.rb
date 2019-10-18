class JobApplication
  include ActiveModel::Validations

  attr_accessor :applicant, :remuneration
  attr_accessor :job_offer, :id, :updated_on, :created_on
  attr_writer :bio

  validates :applicant, :job_offer, presence: true
  validates :bio, length: { maximum: 500, message: 'Bio too long. Max 500 characters' }

  def self.create_for(applicant, offer, remuneration_range, bio = '')
    app = JobApplication.new
    app.applicant = applicant
    app.job_offer = offer
    app.remuneration = remuneration_range
    app.bio = bio
    app
  end

  def bio
    return 'not specified' if @bio.nil? || @bio.empty?

    @bio
  end

  def process
    JobVacancy::App.deliver(:application_notification, :contact_info_email, self)
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end
end
