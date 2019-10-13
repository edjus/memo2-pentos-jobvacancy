require 'spec_helper'

describe RemunerationRange do
  subject(:range) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:min) }
    it { is_expected.to respond_to(:max) }
  end

  describe 'create_for' do
    it 'should be valid to create a range 2000 and 3000' do
      remuneration_rage = described_class.create_for(2000, 3000)
      expect(remuneration_rage.min).to eq(2000)
      expect(remuneration_rage.max).to eq(3000)
    end
  end
end
