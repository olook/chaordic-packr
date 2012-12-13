require "chaordic-packr/packable"

module Chaordic
  module Packr
    class PackableWithInfo < Packable
      # @param [String] prefix optional prefix, if none is given the class name will be used
      # @return [PackableWithInfo]
      def initialize
        # For instance, Chaordic::Packr::PackableWithInfo will get prefixed as packableWithInfo
        class_name = self.class.to_s.sub(/\A.*::/, '')
        @prefix = class_name.sub /\A.{1}/, class_name[0].downcase
        @info = {}
        self
      end

      # @return [String] Prefix for this packable object.
      def prefix
        @prefix
      end

      # Adds information to the package.
      # @param [String] key Key for the information. Will get converted into a string if it isn't one yet.
      # @param [String] value Value for the information key. Will get converted into a string if it isn't one yet.
      # @return [String] Information added.
      def add_info(key, value)
        @info[key.to_s] = value.to_s
      end

      # Adds information to the package, using a hash syntax.
      # @param [Hash] hash One dimension hash. Bear in mind that both keys and values will be converted into strings.
      # @return [Hash] Converted hash.
      def info=(hash)
        @info = Hash[hash.map{|k, v| %W(#{k} #{v}) }]
      end

      # Fetches information from the package.
      # @param [String, nil] key key the the value you want to fetch for. Not providing a key will result on fetching the hole information hash.
      # @return [String, Hash] Value for requested information, or hole information hash if no key was given.
      def info(key = nil)
        key ? @info[key.to_s] : @info
      end

      # @return [Hash] Information hash, using package's prefix
      def to_hash
        Hash[@info.map{|k, v| %W(#{prefix}#{camelize(k)} #{v}) }]
      end

      private
      # NOTE: Copied from Ruby on Rails' ActiveSupport 2.3.14 source (MIT License).
      #
      # By default, +camelize+ converts strings to UpperCamelCase. If the argument to +camelize+
      # is set to <tt>:lower</tt> then +camelize+ produces lowerCamelCase.
      #
      # +camelize+ will also convert '/' to '::' which is useful for converting paths to namespaces.
      #
      # Examples:
      #   "active_record".camelize                # => "ActiveRecord"
      #   "active_record".camelize(:lower)        # => "activeRecord"
      #   "active_record/errors".camelize         # => "ActiveRecord::Errors"
      #   "active_record/errors".camelize(:lower) # => "activeRecord::Errors"
      def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
        if first_letter_in_uppercase
          lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
        else
          lower_case_and_underscored_word.first.downcase + camelize(lower_case_and_underscored_word)[1..-1]
        end
      end
    end
  end
end
