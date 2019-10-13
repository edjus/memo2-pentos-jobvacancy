require 'integration_spec_helper'

describe JobApplicationRepository do
  let(:repository) { described_class.new }
  let(:email1) { 'applicant@test.com' }
  let(:email2) { 'applicant2@test.com' }
  let(:curriculum) { 'linkedin.com/applicant.profile' }
  let(:applicant1) { JobApplicant.create_for(email1, curriculum) }
  let(:applicant2) { JobApplicant.create_for(email2, curriculum) }
  let(:job_offer) { JobOffer.new(id: 1) }

  let(:application1) { JobApplication.create_for(applicant1, job_offer) }
  let(:application2) { JobApplication.create_for(applicant2, job_offer) }

  it 'Given an offer, if a make cero applications,
        when i ask the repository for how many applciants has the offer
        it should be cero applications' do
    expect(repository.how_many_applicants?(job_offer.id)).to eq 0
  end

  it 'Given an offer, if a make two applications,
      when i ask the repository for how many applciants has the offer
      it should be two applications' do
    repository.save(application1)
    repository.save(application2)
    expect(repository.how_many_applicants?(job_offer.id)).to eq 2
  end
end
