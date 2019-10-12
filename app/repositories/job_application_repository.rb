class JobApplicationRepository < BaseRepository
  self.table_name = :job_applications
  self.model_class = 'JobApplication'

  def how_many_applicants?(offer_id)
    applicants = dataset.select(:applicant_email).where(job_offer_id: offer_id).all
    applicants.size
  end

  protected

  def load_object(a_record); end

  def changeset(application)
    {
      applicant_email: application.applicant_email,
      job_offer_id: application.job_offer.id
    }
  end
end
