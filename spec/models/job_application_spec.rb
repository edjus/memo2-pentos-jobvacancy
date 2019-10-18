require 'spec_helper'

describe JobApplication do
  let(:email) { 'applicant@test.com' }
  let(:curriculum) { 'linkedin.com/applicant.profile' }
  let(:applicant) { JobApplicant.create_for(email, curriculum) }
  let(:rem) { RemunerationRange.create_for(2000, 3000) }
  let(:offer) { JobOffer.new }
  let(:applicant_bio) { 'A short bio' }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:job_offer) }
    it { is_expected.to respond_to(:applicant) }
    it { is_expected.to respond_to(:applicant_bio) }
  end

  describe 'create_for' do
    it 'should set applicant' do
      ja = described_class.create_for(applicant, offer, rem, applicant_bio)

      expect(ja.applicant.email).to eq(email)
      expect(ja.applicant.curriculum).to eq(curriculum)
    end

    it 'should set job_offer' do
      ja = described_class.create_for(applicant, offer, rem, applicant_bio)
      expect(ja.job_offer).to eq(offer)
    end

    it 'should set applicant bio' do
      ja = described_class.create_for(applicant, offer, rem, applicant_bio)
      expect(ja.applicant_bio).to eq(applicant_bio)
    end
  end

  describe 'applicant_bio' do
    it 'should return "not specified" when the applicant bio is not set' do
      ja = described_class.create_for(applicant, offer, rem)
      expect(ja.applicant_bio).to eq('not specified')
    end
  end

  describe 'valid?' do
    it 'should be invalid when applicant bio is over 500 characters long' do
      really_long_bio = 'a' * 1000
      ja = described_class.create_for(applicant, offer, rem, really_long_bio)
      expect(ja).not_to be_valid
      expect(ja.errors).to have_key(:applicant_bio)
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
