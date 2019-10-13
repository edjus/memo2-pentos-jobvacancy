require 'spec_helper'

describe RemunerationRange do
  subject(:range) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:min) }
    it { is_expected.to respond_to(:max) }
  end
end
