class JobApplicationRepository < BaseRepository
  self.table_name = :job_applications
  self.model_class = 'JobApplication'

  def how_many_applicants?(offer_id)
    dataset.select(:applicant_email).where(job_offer_id: offer_id).count
  end

  def find_by_offer(offer_id)
    load_collection dataset.where(job_offer_id: offer_id)
  end

  protected

  def load_object(a_record); end

  def changeset(application)
    {
      applicant_email: application.applicant.email,
      applicant_bio: application.applicant_bio,
      job_offer_id: application.job_offer.id
    }
  end
end
