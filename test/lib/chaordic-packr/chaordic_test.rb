require_relative '../../test_helper'

describe Chaordic::Packr::Chaordic do
  it "accepts random AES key on construction" do
    key = Chaordic::Packr::Chaordic.random_aes_key
    key.size.must_equal 24
    Chaordic::Packr::Chaordic.new(key).wont_be_nil
  end

  it "have empty pack" do
    pack = Chaordic::Packr::Chaordic.new.pack Chaordic::Packr::User.new
    pack.must_match(/salt=[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}/)
    pack.must_match(/hash=[a-f0-9]{40}/)
  end

  it "encrypt an empty pack" do
    class FakePackage < Chaordic::Packr::PackableWithInfo
      def unique?; false; end
    end

    pack = Chaordic::Packr::Chaordic.new("YrggeBpQeyB+LXZhr40DBQ==").pack(FakePackage.new)
    pack.must_equal "SMuwZqYBzqBX7afKUXufHhsdDw9TYmuxXEWB80/XKKJybXzJuf7an9mSod9J1yeL"
  end

  it "decrypt an empty package" do
    unpack = Chaordic::Packr::Chaordic.new("YrggeBpQeyB+LXZhr40DBQ==").unpack("SMuwZqYBzqBX7afKUXufHhsdDw9TYmuxXEWB80/XKKJybXzJuf7an9mSod9J1yeL")
    unpack.wont_be_nil
    unpack['salt'].must_be_nil
    unpack['hash'].must_equal 'da39a3ee5e6b4b0d3255bfef95601890afd80709'
  end

  it "packs user without encryption" do
    user = Chaordic::Packr::User.new
    user.uid = '123'
    user.email = 'user@chaordic.com.br'

    pack = Chaordic::Packr::Chaordic.new.pack user
    pack.must_match(/uid=123/)
    pack.must_match(/userEmail=user%40chaordic.com.br/)
    pack.must_match(/salt=[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}/)
    pack.must_match(/hash=[a-f0-9]{40}/)
  end

  it "packs product without encryption" do
    product = Chaordic::Packr::Product.new
    product.pid = '123'
    product.price = 12.45

    pack = Chaordic::Packr::Chaordic.new.pack product
    pack.must_match(/pid=123/)
    pack.must_match(/price=12.45/)
    pack.wont_match(/salt/)
    pack.must_match(/hash=[a-f0-9]{40}/)
  end

  it "encrypt and decrypt an empty cart pack" do
    chaordic = Chaordic::Packr::Chaordic.new("YrggeBpQeyB+LXZhr40DBQ==")
    pack = chaordic.pack Chaordic::Packr::Cart.new
    unpacked = chaordic.unpack pack
    unpacked['salt'].wont_be_nil
    unpacked['hash'].wont_be_nil
    unpacked['uid'].must_be_nil
    unpacked['products'].must_be_nil
  end

  it "decrypt a user pack" do
    encrypted_pack = "euPQF7NCDNe6iPdoGFL3If3h4x8kQkN67zLr+U8KH3jTkIwH6KKm0MRCMDy+rUVxqQvwyBCniftLpy/L9fwQO6qofRQUCHrnD0WoYt6lG180KIDaBl+M9CWedU4rjyrMY3qf8O70v55SJOMOQb2PnOJa91Sx8SUXygVQUojzJaoRhNx4UkPZMPgwUy7tc8KN"

    pack = Chaordic::Packr::Chaordic.new("YrggeBpQeyB+LXZhr40DBQ==").unpack encrypted_pack
    pack['hash'].wont_be_nil
    pack['salt'].wont_be_nil
    pack['uid'].must_equal '123'
    pack['email'].must_equal 'user@chaordicsystems.com'
  end

  it "order keys alphabetically" do
    class FakeOrderedPackage < Chaordic::Packr::PackableWithInfo
      attr_accessor :a, :b, :c
      def unique?; false; end
      # @return [Hash] Information hash.
      def to_hash
        h = super
        h['a'] = a
        h['b'] = b
        h['c'] = c
        h
      end
    end

    package = FakeOrderedPackage.new
    package.add_info :c, '6'
    package.add_info :a, '4'
    package.add_info :b, '5'
    package.add_info :z, '7'
    package.c = '3'
    package.b = '2'
    package.a = '1'
    pack = Chaordic::Packr::Chaordic.new.pack(package)
    pack.must_equal "a=1&b=2&c=3&fakeOrderedPackageA=4&fakeOrderedPackageB=5&fakeOrderedPackageC=6&fakeOrderedPackageZ=7&hash=9c3f6944e750ce92ae2278794f68d3e6f38294ac"
  end
end
