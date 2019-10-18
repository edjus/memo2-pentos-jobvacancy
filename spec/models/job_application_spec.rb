require 'spec_helper'

describe JobApplication do
  let(:email) { 'applicant@test.com' }
  let(:curriculum) { 'linkedin.com/applicant.profile' }
  let(:applicant) { JobApplicant.create_for(email, curriculum) }
  let(:rem) { RemunerationRange.create_for(2000, 3000) }
  let(:offer) { JobOffer.new }
  let(:bio) { 'A short bio' }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:job_offer) }
    it { is_expected.to respond_to(:applicant) }
    it { is_expected.to respond_to(:bio) }
  end

  describe 'create_for' do
    it 'should set applicant' do
      ja = described_class.create_for(applicant, offer, rem, bio)

      expect(ja.applicant.email).to eq(email)
      expect(ja.applicant.curriculum).to eq(curriculum)
    end

    it 'should set job_offer' do
      ja = described_class.create_for(applicant, offer, rem, bio)
      expect(ja.job_offer).to eq(offer)
    end

    it 'should set bio' do
      ja = described_class.create_for(applicant, offer, rem, bio)
      expect(ja.bio).to eq(bio)
    end
  end

  describe 'bio' do
    it 'should return "not specified" when the bio curriculum is not set' do
      ja = described_class.create_for(applicant, offer, rem)
      expect(ja.bio).to eq('not specified')
    end
  end

  describe 'process' do
    it 'should deliver contact info notification' do
      ja = described_class.create_for(applicant, offer, rem)
      expect(JobVacancy::App).to receive(:deliver).with(any_args, :contact_info_email, ja)
      expect(JobVacancy::App).to receive(:deliver).with(any_args, :contact_info_email, ja)
      ja.process
    end
  end
end
