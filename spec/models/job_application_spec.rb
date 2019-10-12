require 'spec_helper'

describe JobApplication do
  let(:email) { 'applicant@test.com' }
  let(:curriculum) { 'linkedin.com/applicant.profile' }
  let(:offer) { JobOffer.new }

  describe 'model' do
    it { is_expected.to respond_to(:applicant_email) }
    it { is_expected.to respond_to(:applicant_curriculum) }
    it { is_expected.to respond_to(:job_offer) }
  end

  describe 'create_for' do
    it 'should set applicant_email' do
      ja = described_class.create_for(email, curriculum, offer)
      expect(ja.applicant_email).to eq(email)
    end

    it 'should set job_offer' do
      ja = described_class.create_for(email, curriculum, offer)
      expect(ja.job_offer).to eq(offer)
    end

    it 'should set applicant_curriculum' do
      ja = described_class.create_for(email, curriculum, offer)
      expect(ja.applicant_curriculum).to eq(curriculum)
    end
  end

  describe 'process' do
    it 'should deliver contact info notification' do
      ja = described_class.create_for(email, curriculum, offer)
      expect(JobVacancy::App).to receive(:deliver).with(:notification, :contact_info_email, ja)
      ja.process
    end
  end
end
