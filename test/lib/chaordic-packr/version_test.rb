require_relative '../../test_helper'

describe Chaordic::Packr do
  it "must be defined" do
    Chaordic::Packr::VERSION.wont_be_nil
  end
end
