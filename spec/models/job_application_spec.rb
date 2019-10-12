require 'spec_helper'

describe JobApplication do
  let(:email) { 'applicant@test.com' }
  let(:offer) { JobOffer.new }

  describe 'model' do
    it { is_expected.to respond_to(:applicant_email) }
    it { is_expected.to respond_to(:applicant_curriculum) }
    it { is_expected.to respond_to(:job_offer) }
  end

  describe 'create_for' do
    it 'should set applicant_email' do
      ja = described_class.create_for(email, offer)
      expect(ja.applicant_email).to eq(email)
    end

    it 'should set job_offer' do
      ja = described_class.create_for(email, offer)
      expect(ja.job_offer).to eq(offer)
    end
  end

  describe 'process' do
    it 'should deliver contact info notification' do
      ja = described_class.create_for(email, offer)
      expect(JobVacancy::App).to receive(:deliver).with(:notification, :contact_info_email, ja)
      ja.process
    end
  end
end
