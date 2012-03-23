# Hashconfig

Extends the Ruby Hash class with a method (merge_with_serialized) that
merges a hash instance with an serialized (YAML) instance of a hash. So
it is a lightweight mechanism for configuration.

[http://github.com/pboehm/hashconfig](http://github.com/pboehm/hashconfig)

## Installation

Add this line to your application's Gemfile:

    gem 'hashconfig'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hashconfig

## Usage

    require 'hashconfig'

    STANDARD_CONFIG = {
        :default_directory  => File.join(File.expand_path("~"), "Downloads"),
        :store_episode_info => false,
        :store_path         => File.join(CONFIG_DIR, "information_storage.yml"),
        :byte_count_for_md5 => 2048,
    }

    config = STANDARD_CONFIG.merge_with_serialized('path/to/yaml/file')

    # config now holds the data from STANDARD_CONFIG updated with values from
    # the yaml file

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
