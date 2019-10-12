require 'spec_helper'

describe JobApplicant do
  let(:email) { 'applicant@test.com' }
  let(:curriculum) { 'linkedin.com/applicant.profile' }

  describe 'model' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:curriculum) }
  end

  describe 'create_for' do
    it 'should set email' do
      applicant = described_class.create_for(email, curriculum)
      expect(applicant.email).to eq(email)
    end

    it 'should set curriculum' do
      applicant = described_class.create_for(email, curriculum)
      expect(applicant.curriculum).to eq(curriculum)
    end
  end

  describe 'curriculum' do
    it 'should return "not specified" when the applicant curriculum is not set' do
      applicant = described_class.create_for(email, '')
      expect(applicant.curriculum).to eq('not specified')
    end
  end
end
