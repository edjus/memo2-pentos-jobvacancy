require 'spec_helper'

describe JobApplication do
  let(:email) { 'applicant@test.com' }
  let(:curriculum) { 'linkedin.com/applicant.profile' }
  let(:applicant) { JobApplicant.create_for(email, curriculum) }
  let(:offer) { JobOffer.new }

  describe 'model' do
    it { is_expected.to respond_to(:applicant) }
    it { is_expected.to respond_to(:job_offer) }
    it { is_expected.to respond_to(:id) }
  end

  describe 'create_for' do
    it 'should set applicant' do
      ja = described_class.create_for(applicant, offer)

      expect(ja.applicant.email).to eq(email)
      expect(ja.applicant.curriculum).to eq(curriculum)
    end

    it 'should set job_offer' do
      ja = described_class.create_for(applicant, offer)
      expect(ja.job_offer).to eq(offer)
    end
  end

  describe 'process' do
    it 'should deliver contact info notification' do
      ja = described_class.create_for(applicant, offer)
      expect(JobVacancy::App).to receive(:deliver).with(:notification, :contact_info_email, ja)
      ja.process
    end
  end
end
