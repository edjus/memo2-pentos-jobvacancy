require 'integration_spec_helper'

describe JobApplicationRepository do
  let(:repository) { described_class.new }
  let(:email1) { 'applicant@test.com' }
  let(:email2) { 'applicant2@test.com' }
  let(:curriculum) { 'linkedin.com/applicant.profile' }
  let(:applicant1) { JobApplicant.create_for(email1, curriculum) }
  let(:applicant2) { JobApplicant.create_for(email2, curriculum) }
  let(:job_offer) { JobOffer.new(id: 1, title: 'a title') }
  let(:rem) { RemunerationRange.create_for(2000, 3000) }

  let(:application1) { JobApplication.create_for(applicant1, job_offer, rem) }
  let(:application2) { JobApplication.create_for(applicant2, job_offer, rem) }

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

  skip 'correctly loads a job application' do
    repository.save(application1)

    application = repository.first

    expect(application.id).to eq(1)
    expect(application.job_offer.id).to eq(1)
    expect(application.applicant.email).to eq(email1)
  end

  describe 'find_by_offer' do
    skip 'returns an empty array when there are no applications for a given offer' do
      offer_id = 2

      applications = repository.find_by_offer(offer_id)

      expect(applications.empty?).to eq(true)
    end

    skip 'returns an array with the offer applications' do
      repository.save(application1)
      repository.save(application2)

      offer_id = 1
      applications = repository.find_by_offer(offer_id)

      expect(applications.size).to eq(2)
    end
  end
end
