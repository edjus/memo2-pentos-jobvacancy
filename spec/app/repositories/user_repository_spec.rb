require 'integration_spec_helper'

describe UserRepository do
  let(:repository) { described_class.new }
  let(:user) { User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd') }

  describe 'email validation' do
    it 'should not be valid to register with an existing email' do
      repository.save(user)
      new_user = User.new(name: 'Joh', email: 'joe@doe.com', crypted_password: 'secure_pwd!')
      expect { repository.save(new_user) }.to raise_error(EmailAlreadyInUseError)
    end
  end
end
