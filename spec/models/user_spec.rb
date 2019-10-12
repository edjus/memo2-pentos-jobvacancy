require 'spec_helper'

describe User do
  subject(:user) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:crypted_password) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:job_offers) }
  end

  describe 'valid?' do
    it 'should be false when name is blank' do
      user = described_class.new(email: 'john.doe@someplace.com',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:name)
    end

    it 'should be false when email is not valid' do
      user = described_class.new(name: 'John Doe', email: 'john',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:email)
    end

    it 'should be false when password is blank' do
      user = described_class.new(name: 'John Doe', email: 'john')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:crypted_password)
    end

    it 'should be true when all field are valid' do
      user = described_class.new(name: 'John Doe', email: 'john@doe.com',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq true
    end
  end

  describe 'has password?' do
    let(:password) { 'pass.wordP' }
    let(:user) do
      described_class.new(password: password,
                          email: 'john.doe@someplace.com',
                          name: 'john doe')
    end

    it 'should return false when password do not match' do
      expect(user).not_to have_password('invalid')
    end

    it 'should return true when password do  match' do
      expect(user).to have_password(password)
    end
  end

  describe 'password validation' do
    it 'raise error when password size is less than 8 characters' do
      expect do
        described_class.new(email: 'john.doe@someplace.com', password: 'got')
      end.to raise_error 'passwords must have at least 8 characters'
    end

    it 'raise error when password does not have upper case character' do
      expect do
        described_class.new(email: 'john.doe@someplace.com', password: 'asdfghjkl')
      end.to raise_error 'passwords must have at least one Upper Case character'
    end

    it 'dont raise error when password have one upper case character' do
      expect do
        described_class.new(email: 'john.doe@someplace.com', password: 'asdfghjkL')
      end.not_to raise_error 'passwords must have at least one Upper Case character'
    end

    it 'dont raise error when password have some upper case characters' do
      expect do
        described_class.new(email: 'john.doe@someplace.com', password: 'asDfGhjkL')
      end.not_to raise_error 'passwords must have at least one Upper Case character'
    end

    it 'raise error when password does not have special character' do
      expect do
        described_class.new(email: 'john.doe@someplace.com', password: 'asdfghBjkl')
      end.to raise_error 'passwords must have at least one special character'
    end
  end
end
