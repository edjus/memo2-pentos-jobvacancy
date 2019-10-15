require 'spec_helper'

describe RemunerationRange do
  subject(:range) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:min) }
    it { is_expected.to respond_to(:max) }
  end

  describe 'create_for' do
    it 'should be valid to create a range 2000 and 3000' do
      remuneration_range = described_class.create_for(2000, 3000)
      expect(remuneration_range.min).to eq(2000)
      expect(remuneration_range.max).to eq(3000)
    end
  end

  describe 'valid?' do
    it 'should not be valid create a range 2000 and 3000' do
      remuneration_range = described_class.create_for(2000, 3000)
      expect(remuneration_range).to be_valid
    end

    it 'should not be valid create a range null and null' do
      remuneration_range = described_class.create_for(nil, nil)
      expect(remuneration_range).not_to be_valid
    end

    it 'should be valid create a range 2000 and null' do
      remuneration_range = described_class.create_for(2000, nil)
      expect(remuneration_range).to be_valid
    end

    it 'should not be valid create a range -3000 and 3000' do
      remuneration_range = described_class.create_for(-3000, 3000)
      expect(remuneration_range).not_to be_valid
    end

    it 'should not be valid create a range 3000 and -3000' do
      remuneration_range = described_class.create_for(3000, -3000)
      expect(remuneration_range).not_to be_valid
    end

    it 'should not be valid create a range 60000 and 30000' do
      remuneration_range = described_class.create_for(60_000, 30_000)
      expect(remuneration_range).not_to be_valid
    end
  end
end
