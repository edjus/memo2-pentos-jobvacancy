# Helper methods defined here can be accessed in any controller or view in the application

JobVacancy::App.helpers do
  def job_offer_params
    params[:job_offer].to_h.symbolize_keys
  end

  def applicants(offer_id)
    JobApplicationRepository.new.how_many_applicants?(offer_id)
  end
end
