require 'integration_spec_helper'

describe JobApplicationRepository do
  let(:repository) { described_class.new }

  it 'Given an offer, if a make cero applications,
        when i ask the repository for how many applciants has the offer
        it should be cero applications' do

    job_offer = JobOffer.new
    expect(repository.how_many_applicants?(job_offer.id)).to eq 0
  end
end
