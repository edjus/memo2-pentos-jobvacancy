require 'spec_helper'

describe JobApplicant do
  describe 'model' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:curriculum) }
  end
end
