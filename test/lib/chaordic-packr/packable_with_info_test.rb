require_relative '../../test_helper'

describe Chaordic::Packr::PackableWithInfo do
  it 'is exists' do
    Chaordic::Packr::PackableWithInfo.new.wont_be_nil
  end

  it 'is always unique' do
    pack = Chaordic::Packr::PackableWithInfo.new
    pack.unique?.must_equal true
  end

  it 'have a prefix' do
    Chaordic::Packr::PackableWithInfo.new.prefix.must_equal 'packableWithInfo'

    class Dummy < Chaordic::Packr::PackableWithInfo; end
    Dummy.new.prefix.must_equal 'dummy'

    class AnotherDummy < Chaordic::Packr::PackableWithInfo; end
    AnotherDummy.new.prefix.must_equal 'anotherDummy'
  end

  it 'packs information' do
    pack = Chaordic::Packr::PackableWithInfo.new
    pack.add_info :a, 1
    pack.add_info :ab, '12'
    pack.add_info 'aBc', '123'
    pack.info('a').must_equal '1'
    pack.info('ab').must_equal '12'
    pack.info('aBc').must_equal '123'
    pack.info(:a).must_equal pack.info('a')
  end

  it 'packs information using hash as input' do
    pack = Chaordic::Packr::PackableWithInfo.new
    pack.info = { a: 1, ab: 12, aBc: 123 }
    pack.info('a').must_equal '1'
    pack.info('ab').must_equal '12'
    pack.info('aBc').must_equal '123'
    pack.info.must_equal({"a" => "1", "ab" => "12", "aBc" => "123"})
  end

  it 'maps data with prefix' do
    pack = Chaordic::Packr::PackableWithInfo.new
    pack.add_info :a, 1
    pack.add_info :ab, '12'
    pack.add_info 'aBc', '123'
    pack.to_hash.must_equal({
      'packableWithInfoA' => '1',
      'packableWithInfoAb' => '12',
      'packableWithInfoABc' => '123'
    })
  end
end
