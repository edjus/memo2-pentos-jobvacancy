require 'spec_helper'

describe JobApplicant do
  let(:email) { 'applicant@test.com' }
  let(:curriculum) { 'linkedin.com/applicant.profile' }
  let(:bio) { 'This my bio' }

  describe 'model' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:curriculum) }
    it { is_expected.to respond_to(:bio) }
  end

  describe 'create_for' do
    it 'should set email' do
      applicant = described_class.create_for(email, curriculum, bio)
      expect(applicant.email).to eq(email)
      expect(applicant.bio).to eq(bio)
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

  describe 'bio' do
    it 'should return "not specified" when the bio curriculum is not set' do
      applicant = described_class.create_for(email, '')
      expect(applicant.bio).to eq('not specified')
    end
  end
end
