require "chaordic-packr/packable_with_info"
require 'oj'

module Chaordic
  module Packr
    # Product variant
    class Variant
      attr_accessor :name, :sku, :price, :old_price

      # @param [String] name Product name.
      # @param [String] sku Product storage identification.
      # @param [Numeric] price Product price.
      # @param [Numeric] old_price Old product price.
      # @return [Item]
      def initialize(name, sku = nil, price = nil, old_price = nil)
        self.name = name.to_s
        self.sku = sku.to_s if sku
        self.price = price.to_f if price
        self.old_price = old_price.to_f if old_price
        self
      end

      # @return [Hash] Hash for variant.
      def to_hash
        h = { 'name' => name }
        h['sku'] = sku if sku
        h['price'] = price if price
        h['oldPrice'] = old_price if old_price
        h
      end
    end
  end
end
