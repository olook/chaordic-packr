require "chaordic-packr/packable_with_info"
require "chaordic-packr/cart"

module Chaordic
  module Packr
    class BuyOrder < PackableWithInfo
      # @param [Cart] cart Shopping cart.
      # @return [BuyOrder]
      def initialize(cart)
        @cart = cart if cart.instance_of? Cart
        @tags = []
        super()
      end

      # @param [String] id Order identification.
      # @return [String] Set order identification.
      def oid=(id)
        @oid = id
      end

      # @return [String] Order identification.
      def oid
        @oid
      end

      # @param [Array<String>] ts Product tags.
      # @return [Array<String>] Set product tags, overwriting the existing Array of strings.
      def tags=(ts)
        @tags = ts.map{|t| t.to_s } if t.kind_of? Array
      end

      # @return [Array<String>] Product tags.
      def tags; @tags; end

      # @return [Hash] Information hash, using package's prefix. If there's a user, also include user's information hash.
      def to_hash
        h = super
        h.merge! @cart.to_hash
        h['oid'] = @oid
        h['buyOrderTags'] = Oj.dump(@tags.uniq) if @tags.any?
        h
      end
    end
  end
end
