require 'spec_helper'
require 'yaml'

require File.dirname(__FILE__) + '/../lib/hashconfig'

TEST_DATA = {
  :first  => "first parameter",
  :second => "second parameter",
  :third  => "third parameter"
}

TEST_DIR                 = File.join( File.dirname(__FILE__), "testfiles")
TEST_CONFIG_FILE         = File.join(TEST_DIR, "config.yml")
TEST_EMPTY_CONFIG_FILE   = File.join(TEST_DIR, "empty.yml")
TEST_INVALID_CONFIG_FILE = File.join(TEST_DIR, "invalid.yml")
TEST_NOT_EXISTING        = File.join(TEST_DIR, "not_exisiting.yml")


describe Hashconfig do

  before(:all) do

    @modified = TEST_DATA.merge({:third => "modified third parameter"})

    FileUtils.mkdir(TEST_DIR) unless File.directory? TEST_DIR
    File.open(TEST_CONFIG_FILE, 'w') {|f| f.write(@modified.to_yaml) }
    File.open(TEST_EMPTY_CONFIG_FILE, 'w') {|f| f.write(Hash.new.to_yaml) }
    File.open(TEST_EMPTY_CONFIG_FILE, 'w') {|f| f.write("invalid") }

  end

  after(:all) do
    FileUtils.remove_dir(TEST_DIR) if File.directory? TEST_DIR
  end

  it "should add a method to the Ruby Hash class" do
    Hash.new.respond_to?(:merge_with_serialized).should be_true
  end

  it "should return an updated hash when yaml file is valid" do
    config = TEST_DATA.merge_with_serialized(TEST_CONFIG_FILE)
    config[:third].should eq "modified third parameter"
  end

  it "should return original hash when yaml file is empty" do
    config = TEST_DATA.merge_with_serialized(TEST_EMPTY_CONFIG_FILE)
    config[:third].should eq "third parameter"
  end

  it "should return original hash when yaml file is invalid" do
    config = TEST_DATA.merge_with_serialized(TEST_INVALID_CONFIG_FILE)
    config[:third].should eq "third parameter"
  end

  it "should return original hash when yaml file is not exisiting" do
    config = TEST_DATA.merge_with_serialized(TEST_INVALID_CONFIG_FILE)
    config[:third].should eq "third parameter"
  end

  it "should update the yaml when it is merged with a different hash" do
    updated = TEST_DATA.merge({:fourth => "parameter number 4"})
    config = updated.merge_with_serialized(TEST_CONFIG_FILE)
    config[:fourth].should eq "parameter number 4"
  end
end

