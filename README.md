# Phonetic

RubyLib for phonetic algorithms.
At the moment only the modified soundex algorithm for german words aka Kölner Phonetik.

## Installation

Add this line to your application's Gemfile:

    gem 'phonetic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install phonetic

## Usage

require 'phonetic'

include Phonetic

soundex_ger("Müller-Lüdenscheidt")
=> 65752682

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
