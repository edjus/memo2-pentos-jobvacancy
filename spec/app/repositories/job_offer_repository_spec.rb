require 'integration_spec_helper'

describe JobOfferRepository do
  let(:repository) { described_class.new }

  let(:owner) do
    user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    UserRepository.new.save(user)
    user
  end

  describe 'deactive_old_offers' do
    let!(:today_offer) do
      today_offer = JobOffer.new(title: 'a title',
                                 updated_on: Date.today,
                                 is_active: true,
                                 user_id: owner.id)
      repository.save(today_offer)
      today_offer
    end

    let!(:thirty_day_offer) do
      thirty_day_offer = JobOffer.new(title: 'a title',
                                      updated_on: Date.today - 45,
                                      is_active: true,
                                      user_id: owner.id)
      repository.save(thirty_day_offer)
      thirty_day_offer
    end

    it 'should deactivate offers updated 45 days ago' do
      repository.deactivate_old_offers

      updated_offer = repository.find(thirty_day_offer.id)
      expect(updated_offer.is_active).to eq false
    end

    it 'should not deactivate offers created today' do
      repository.deactivate_old_offers

      not_updated_offer = repository.find(today_offer.id)
      expect(not_updated_offer.is_active).to eq true
    end
  end

  describe 'delete job offer' do
    let(:applicant) do
      JobApplicant.create_for('applicant@test.com',
                              'linkedin.com/applicant.profile')
    end
    let(:rem) { RemunerationRange.create_for(2000, 3000) }
    let(:job_offer) do
      JobOffer.new(title: 'a title',
                   is_active: true,
                   user_id: owner.id)
    end

    it 'should not be possible to delete offer with applicants' do
      repository.save(job_offer)
      app = JobApplication.create_for(applicant, job_offer, rem)
      JobApplicationRepository.new.save(app)
      expect { repository.destroy(job_offer) }.to raise_error(OfferWithApplicationsError)
    end
  end
end
