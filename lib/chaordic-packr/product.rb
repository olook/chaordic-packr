require "chaordic-packr/packable_with_info"
require "chaordic-packr/variant"
require "oj"

module Chaordic
  module Packr
    class Product < PackableWithInfo
      Status = { available: 'AVAILABLE', unavailable: 'UNAVAILABLE', removed: 'REMOVED', disabled: 'DISABLED' }

      attr_accessor :pid, :price, :old_price, :status, :detail_url, :image_name, :category, :sub_category, :sub_sub_category, :name

      def initialize
        @tags = []
        @variants = []
        super
      end

      # @param [String] d Product description.
      # @return [String] Set product description.
      def description=(d); self.add_info :description, d; end

      # @return [String] Product description.
      def description; self.info :description; end

      # @param [String] d Product's installment count.
      # @return [String] Set product's installment count.
      def installment_count=(d); self.add_info :installment_count, d; end

      # @return [String] Product's installment count.
      def installment_count; self.info :installment_count; end

      # @param [String] d Product's installment price.
      # @return [String] Set product's installment price.
      def installment_price=(d); self.add_info :installment_price, d; end

      # @return [String] Product's installment price.
      def installment_price; self.info :installment_price; end

      # @param [Float, Numeric] d Price.
      # @return [Float] Set product price, rounded with 2 decimal numbers.
      def price=(d)
        @price = (d.to_f * 100).round.to_f / 100
      end

      # @return [String] Price, always as a string.
      def price
        @price.to_s
      end

      # @param [Float, Numeric] d Old price.
      # @return [Float] Set product old price, rounded with 2 decimal numbers.
      def old_price=(d)
        @old_price = (d.to_f * 100).round.to_f / 100
      end

      # @return [String] Old price, always as a string.
      def old_price
        @old_price.to_s
      end

      # @param [Array<String>] ts Product tags.
      # @return [Array<String>] Set product tags, overwriting the existing Array of strings.
      def tags=(ts)
        @tags = ts.map{|t| t.to_s } if t.kind_of? Array
      end

      # @return [Array<String>] Product tags.
      def tags; @tags; end

      def add_variant(*args)
        @variants << Variant.new(*args)
      end

      # @return [true, false] Products are not unique.
      def unique?; false; end

      # @return [Hash] Information hash.
      def to_hash
        h = super
        h['pid'] = pid
        h['price'] = price
        h['oldPrice'] = old_price
        h['status'] = status
        h['detailUrl'] = detail_url
        h['imageName'] = image_name
        h['category'] = category
        h['subCategory'] = sub_category
        h['subSubCategory'] = sub_sub_category
        h['name'] = name
        h['productVariant'] = Oj.dump(@variants.map{|v| v.to_hash })
        h['tags'] = Oj.dump(@tags.uniq) if @tags.any?
        h
      end
    end
  end
end
