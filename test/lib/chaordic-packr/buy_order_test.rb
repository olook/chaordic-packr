require_relative '../../test_helper'

describe Chaordic::Packr::BuyOrder do
  it 'is exists' do
    Chaordic::Packr::BuyOrder.new(nil).wont_be_nil
  end

  it 'have a prefix' do
    Chaordic::Packr::BuyOrder.new(nil).prefix.must_equal 'buyOrder'
  end

  it 'can buy using a cart' do
    cart = Chaordic::Packr::Cart.new
    cart.user = Chaordic::Packr::User.new
    cart.user.uid = '123'

    cart.add_product '1', 123.45
    cart.add_product '2', 45.67

    order = Chaordic::Packr::BuyOrder.new cart
    order.oid = '456'
    order.tags << 'happyTag'
    order.tags << 'sadTag'

    order.to_hash.must_equal(cart.user.to_hash.merge({
      'products' => "[{\"pid\":\"1\",\"price\":123.45},{\"pid\":\"2\",\"price\":45.67}]",
      'oid' => '456',
      'buyOrderTags' => "[\"happyTag\",\"sadTag\"]"
    }))
  end

  it 'have unique tags' do
    order = Chaordic::Packr::BuyOrder.new Chaordic::Packr::Cart.new
    order.tags << 'ma'
    order.tags << 'ma'
    order.tags << 'oe'

    order.to_hash['buyOrderTags'].must_equal "[\"ma\",\"oe\"]"
  end
end
