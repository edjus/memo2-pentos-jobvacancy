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

  def load_object(a_record)
    applicant = JobApplicant.create_for(a_record[:applicant_email],
                                        a_record[:applicant_curriculum])

    offer = JobOfferRepository.new.find(a_record[:job_offer_id])

    remuneration = RemunerationRange.create_for(a_record[:remuneration_min],
                                                a_record[:remuneration_max])

    application = JobApplication.create_for(applicant,
                                            offer,
                                            remuneration,
                                            a_record[:applicant_bio])

    application.created_on = a_record[:created_on]

    application
  end

  def changeset(application)
    {
      applicant_email: application.applicant.email,
      applicant_curriculum: application.applicant.curriculum,
      applicant_bio: application.applicant_bio,
      remuneration_min: application.remuneration.min,
      remuneration_max: application.remuneration.max,
      job_offer_id: application.job_offer.id
    }
  end
end
