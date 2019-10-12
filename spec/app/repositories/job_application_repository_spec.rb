require 'integration_spec_helper'

describe JobApplicationRepository do
  let(:repository) { described_class.new }

  let(:application2) { JobApplication.create_for('email1@gmail.com', job_offer) }
  let(:application1) { JobApplication.create_for('email2@gmail.com', job_offer) }
  let(:job_offer) { JobOffer.new(id: 1) }

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
