class JobApplicationRepository < BaseRepository
  self.table_name = :job_application
  self.model_class = 'JobApplication'

  def how_many_applicants?(_offer_id)
    0
  end

  protected

  def load_object(a_record); end

  def changeset(_offer)
    {

    }
  end
end
