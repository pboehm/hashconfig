require "hashconfig/version"
require 'hash_deep_merge'
require 'yaml'

module Hashconfig

  class ::Hash

    # this method merges a YAML-serialized hash-instance
    # with self. if the given File is not exisiting this will write
    # a serialized version of self to this file.
    #
    # if the given yaml file does not contain a serialized hash than it
    # merges with an empty hash that returns self unchanged.
    #
    # returns a new Hash merged with deserialized version from the file
    def merge_with_serialized(yaml_file)

      unless File.file? yaml_file
        File.open(yaml_file, 'w') {|f| f.write(self.to_yaml) }
      end

      persistent_config = YAML.load(File.new(yaml_file, "rb").read)
      persistent_config = Hash.new unless persistent_config.is_a? Hash

      config = self.deep_merge(persistent_config)
      File.open(yaml_file, 'w') {|f| f.write(config.to_yaml) }

      return config
    end
  end

end
