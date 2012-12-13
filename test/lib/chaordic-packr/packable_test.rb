require_relative '../../test_helper'

describe Chaordic::Packr::Packable do
  it "is exists" do
    Chaordic::Packr::Packable.new.wont_be_nil
  end

  it "is always unique" do
    pack = Chaordic::Packr::Packable.new
    pack.unique?.must_equal true
  end
end
