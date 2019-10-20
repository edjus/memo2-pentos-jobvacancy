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

  describe 'valid?' do
    it 'should be invalid when email is blank' do
      applicant = described_class.create_for('', '')
      expect(applicant).not_to be_valid
      expect(applicant.errors).to have_key(:email)
    end

    it 'should be invalid when email do not have domain' do
      applicant = described_class.create_for('email.with.no.domain', '')
      expect(applicant).not_to be_valid
      expect(applicant.errors).to have_key(:email)
    end
  end
end
