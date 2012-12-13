require_relative '../../test_helper'

describe Chaordic::Packr::Product do
  it 'is exists' do
    Chaordic::Packr::Product.new.wont_be_nil
  end

  it 'have a prefix' do
    Chaordic::Packr::Product.new.prefix.must_equal 'product'
  end

  it "is not unique" do
    Chaordic::Packr::Product.new.unique?.must_equal false
  end

  it 'have data' do
    product = Chaordic::Packr::Product.new

    product.pid = '123'
    product.price = 123.45
    product.old_price = 456.78
    product.status = Chaordic::Packr::Product::Status[:available]
    product.detail_url = 'chaordic.com.br/product/1'
    product.image_name = 'image.png'
    product.tags << 'tag1'
    product.tags << 'tag2'
    product.tags.size.must_equal 2
    product.category = 'Cat'
    product.sub_category = 'Sub Cat'
    product.sub_sub_category = 'Sub Sub Cat'
    product.name = 'Product Name'
    product.description = 'Product Description'
    product.installment_count = 12
    product.installment_price = 12.34
    product.add_variant('L', '0')
    product.add_variant('XL', '1', 234.56, 345.67)

    product.to_hash.must_equal({
      'pid' => '123',
      'price' => '123.45',
      'oldPrice' => '456.78',
      'status' => 'AVAILABLE',
      'detailUrl' => 'chaordic.com.br/product/1',
      'imageName' => 'image.png',
      'tags' => "[\"tag1\",\"tag2\"]",
      'category' => 'Cat',
      'subCategory' => 'Sub Cat',
      'subSubCategory' => 'Sub Sub Cat',
      'name' => 'Product Name',
      'productDescription' => 'Product Description',
      'productInstallmentCount' => '12',
      'productInstallmentPrice' => '12.34',
      'productVariant' => "[{\"name\":\"L\",\"sku\":\"0\"},{\"name\":\"XL\",\"sku\":\"1\",\"price\":234.56,\"oldPrice\":345.67}]"
    })
  end

  it 'have unique tags' do
    product = Chaordic::Packr::Product.new
    product.tags << 'ma'
    product.tags << 'ma'
    product.tags << 'oe'

    product.to_hash['tags'].must_equal "[\"ma\",\"oe\"]"
  end
end
