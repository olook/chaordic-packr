# Chaordic::Packr

<dl>
  <dt>Homepage</dt><dd><a href="http://www.chaordicsystems.com/">www.chaordicsystems.com</a></dd>
  <dt>Author</dt><dd><a href="mailto:rossato@chaordicsystems.com">Chaordic Systems</a></dd>
  <dt>Copyright</dt><dd>Copyright © 2012 Chaordic Systems Inc.</dd>
</dl>

Integration with Chaordic's infrastructure, packing and unpacking product-related information with AES 128bit cryptography.

## Reference

- {Chaordic::Packr::Chaordic}

Packable objects:

- {Chaordic::Packr::BuyOrder}
- {Chaordic::Packr::Cart}
- {Chaordic::Packr::Product}
- {Chaordic::Packr::User}

## Example Usage

    require 'chaordic-packr'
    cart = Chaordic::Packr::Cart.new
    cart.add_product "Book", 11.99
    chaordic = Chaordic::Packr::Chaordic.new("jSmJSqCh94ns+E8k+x/3xQ==")
    pack = chaordic.pack cart

    unpacked = chaordic.unpack pack
    puts unpacked['products'] # => [{"pid":"Book","price":11.99}]

## Installation

Add this line to your application's Gemfile:

    gem 'chaordic-packr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chaordic-packr
