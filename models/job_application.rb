class JobApplication
  include ActiveModel::Validations

  attr_accessor :applicant
  attr_accessor :job_offer, :id, :updated_on, :created_on

  validates :applicant, :job_offer, presence: true

  def self.create_for(applicant, offer)
    app = JobApplication.new
    app.applicant = applicant
    app.job_offer = offer
    app
  end

  def process
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end
end
