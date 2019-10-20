# Helper methods defined here can be accessed in any controller or view in the application

JobVacancy::App.helpers do
  def job_offer_params
    params[:job_offer].to_h.symbolize_keys
  end

  def applicants(offer_id)
    JobApplicationRepository.new.how_many_applicants?(offer_id)
  end

  def extract_first_error(entity)
    return '' if entity.errors.empty?

    # Ex: entity.errors.messages = [:symbol, ["the error"]]
    entity.errors.messages.first[1].first
  end

  def button_enabled?(offer_id)
    applicants(offer_id).zero?
  end

  def build_job_application_from_params(params)
    applicant = JobApplicant.create_for(params[:applicant_email],
                                        params[:applicant_curriculum])
    raise InvalidEmailApplicantError if applicant.invalid?

    remuneration = RemunerationRange.create_for(params[:expected_remuneration_min],
                                                params[:expected_remuneration_max])
    raise InvalidRemunerationRangeError if remuneration.invalid?

    JobApplication.create_for(applicant, @job_offer, remuneration, params[:bio])
  end
end
