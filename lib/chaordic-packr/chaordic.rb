require "chaordic-packr/packable_with_info"
require "chaordic-packr/cart"
require "openssl"
require "base64"
require "addressable/uri"
require "securerandom"

module Chaordic
  module Packr
    class Chaordic
      # @param [String] aes_key AES key, usualy 24 chars wide
      # @return [Chaordic] Constructor for Chaordic object.
      def initialize(aes_key = nil)
        @aes_key = aes_key
        self
      end

      # @param [Packable] packable Object that needs to be packed.
      # @return [String] Serialized pack (encrypted if an AES key is available).
      def pack(packable)
        serialized = serialize packable
        serialized = encrypt serialized if @aes_key
        serialized
      end

      # @param [String] string Serialized (and often encrypted) packable object.
      # @return [Packable] Object unpacked (and decrypted if an AES was available).
      def unpack(string)
        string = decrypt string if @aes_key
        deserialize string
      end

      private
      # @param [Packable] packable
      # @return [String] Serialized pack
      def serialize(packable)
        h = Hash[*packable.to_hash.sort.flatten] # Orders packable.to_hash
        h['salt'] = SecureRandom.uuid if packable.unique?
        h['hash'] = digest_for_hash(h)

        uri = Addressable::URI.new
        uri.query_values = h
        uri.query
      end

      # @param [String] string String to get deserialized (from an URI).
      # @return [Hash] Hash with deserialized data.
      def deserialize(string)
        uri = Addressable::URI.new
        uri.query = string
        uri.query_values
      end

      # @param [Hash] hash Hash to generate digest for.
      # @return [String] Digest for hash. Note that we first convert the hash into a serialized query data only then to actually generate the digest for it
      def digest_for_hash(hash)
        uri = Addressable::URI.new
        uri.query_values = hash
        uri_query_values = uri.query
        
        OpenSSL::Digest::SHA1.new(uri_query_values).hexdigest
      end

      # @param [String] string String to encrypt.
      # @return [String] Base 64 string, encrypted using AES 128 CBC, using the AES key set on this object's constructor.
      def encrypt(string)
        cypher = OpenSSL::Cipher::AES.new(128, :CBC)
        cypher.encrypt
        cypher.iv = @aes_key[0...16].encode('utf-8')
        cypher.key = Base64.decode64 @aes_key.encode('utf-8')
        crypted = cypher.update(string) + cypher.final
        Base64.encode64(crypted).gsub /\n/, ''
      end

      # @param [String] string String to get decrypted.
      # @return [String] Decrypted version of string.
      def decrypt(string)
        cypher = OpenSSL::Cipher::AES.new(128, :CBC)
        cypher.decrypt
        cypher.iv = @aes_key[0...16].encode('utf-8')
        cypher.key = Base64.decode64 @aes_key.encode('utf-8')
        prepared_for_decryption = Base64.decode64 string
        cypher.update(prepared_for_decryption) + cypher.final
      end

      class << self
        # @return [String] Generate a random AES key, UTF-8 encoded.
        def random_aes_key
          cypher = OpenSSL::Cipher::AES.new(128, :CBC)
          Base64.encode64(cypher.encrypt.random_key).encode('utf-8').chomp
        end
      end
    end
  end
end
