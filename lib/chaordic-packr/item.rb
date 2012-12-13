module Chaordic
  module Packr
    # Item for shopping cart.
    class Item
      # @param [String] pid Product identification.
      # @param [Numeric] price Product price.
      # @param [String] variant Product variant.
      # @return [Item]
      def initialize(pid = nil, price = nil, variant = nil)
        self.pid = pid if pid
        self.price = price if price
        self.variant = variant if variant
        self
      end

      # @param [String] pid Product identification.
      # @return [String] Set product identification.
      def pid=(pid)
        @pid = pid
      end

      # @return [String] Product identification.
      def pid
        @pid
      end

      # @param [Numeric] price Price.
      # @return [Numeric] Set price.
      def price=(price)
        @price = (price.to_f * 100).round.to_f / 100
      end

      # @return [Numeric] Price.
      def price
        @price
      end

      # @param [String] variant Product variant.
      # @return [String] Set product variant.
      def variant=(variant)
        @variant = variant
      end

      # @return [String] Product variant.
      def variant
        @variant
      end

      def to_hash
        h = { 'pid' => @pid, 'price' => @price }
        h['variant'] = @variant if @variant
        h
      end
    end
  end
end
