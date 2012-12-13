require_relative '../../test_helper'

describe Chaordic::Packr::Variant do
  it 'is convertable to hash' do
    variant = Chaordic::Packr::Variant.new('L', '0')
    variant.to_hash.must_equal({"name"=>"L", "sku"=>"0"})

    variant = Chaordic::Packr::Variant.new('XL', '1', 234.56, 345.67)
    variant.to_hash.must_equal({"name"=>"XL", "sku"=>"1", "price"=>234.56, "oldPrice"=>345.67})
  end
end
