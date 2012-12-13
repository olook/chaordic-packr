require_relative '../../test_helper'

describe Chaordic::Packr::Cart do
  it 'is exists' do
    Chaordic::Packr::Cart.new.wont_be_nil
  end

  it 'have a user' do
    cart = Chaordic::Packr::Cart.new
    cart.user = Chaordic::Packr::User.new
  end

  it 'maps' do
    cart = Chaordic::Packr::Cart.new

    cart.add_product '1', 123.45
    cart.add_product '2', 45.67

    cart.to_hash.must_equal({
      'products' => "[{\"pid\":\"1\",\"price\":123.45},{\"pid\":\"2\",\"price\":45.67}]"
    })
  end

  it 'maps with an user' do
    cart = Chaordic::Packr::Cart.new
    cart.user = Chaordic::Packr::User.new
    cart.user.uid = '123'

    cart.add_product '1', 123.45
    cart.add_product '2', 45.67

    cart.to_hash.must_equal(cart.user.to_hash.merge({
      'products' => "[{\"pid\":\"1\",\"price\":123.45},{\"pid\":\"2\",\"price\":45.67}]"
    }))
  end

  it 'maps with an user and variant' do
    cart = Chaordic::Packr::Cart.new
    cart.user = Chaordic::Packr::User.new
    cart.user.uid = '123'

    cart.add_product '1', 123.45, 'a'
    cart.add_product '2', 45.67, 'b'

    cart.to_hash.must_equal(cart.user.to_hash.merge({
      'products' => "[{\"pid\":\"1\",\"price\":123.45,\"variant\":\"a\"},{\"pid\":\"2\",\"price\":45.67,\"variant\":\"b\"}]"
    }))
  end
end
