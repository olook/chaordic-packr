require "chaordic-packr/packable_with_info"

module Chaordic
  module Packr
    class User < PackableWithInfo
      # @param [String] id User identification.
      # @return [String] Set user identification.
      def uid=(id)
        @uid = id
      end

      # @return [String] User identification.
      def uid
        @uid
      end

      # @param [String] name User name.
      # @return [String] Set user name.
      def name=(name)        
        self.add_info :name, name
      end

      # @return [String] User name.
      def name
        self.info[:name]
      end

      # @param [String] email User email address.
      # @return [String] Set user email address.
      def email=(email)
        self.add_info :email, email
      end

      # @return [String] User email address.
      def email
        self.info[:email]
      end

      # Set user information hash. Bear in mind that 'uid' is special and isn't affected by the package's prefix.
      # @return [Hash] User information hash.
      def to_hash
        h = super
        h['uid'] = @uid
        h
      end
    end
  end
end
