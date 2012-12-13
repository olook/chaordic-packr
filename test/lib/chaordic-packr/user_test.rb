require_relative '../../test_helper'

describe Chaordic::Packr::User do
  it 'is exists' do
    Chaordic::Packr::User.new.wont_be_nil
  end

  it 'have a prefix' do
    Chaordic::Packr::User.new.prefix.must_equal 'user'
  end

  it 'have data' do
    user = Chaordic::Packr::User.new
    user.uid = '123'
    user.name = 'User'
    user.email = 'user@chaordicsystems.com'

    user.to_hash.must_equal({
      'uid' => '123',
      'userName' => 'User',
      'userEmail' => 'user@chaordicsystems.com'
    })
  end
end
