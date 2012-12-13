require "chaordic-packr/packable"
require "chaordic-packr/user"
require "chaordic-packr/item"
require "oj"

module Chaordic
  module Packr
    # Shopping cart.
    class Cart < Packable
      def initialize
        @products = []
      end

      def add_product(pid, price, variant = nil)
        @products << Item.new(pid, price, variant)
      end

      # @param [User] u User.
      # @return [User] Set user for this shopping cart.
      def user=(u)
        @user = u if u.kind_of? User
      end

      # @return [User] User for this shopping cart.
      def user
        @user
      end

      # @return [Hash] Information hash, using package's prefix. If there's a user, also include user's information hash.
      def to_hash
        h = @user ? @user.to_hash : {}
        h['products'] = Oj.dump(@products.map {|item| item.to_hash }) if @products.any?
        h
      end
    end
  end
end
