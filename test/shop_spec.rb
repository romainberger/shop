require 'shop'
require 'fileutils'

path = File.expand_path File.dirname(__FILE__)
path = "#{path}/../"

describe Shop, '#init' do
  after(:all) { File.delete("#{path}.shop") }

  it "should create the local config file" do
    Shop::Command::init('theme_name')
    isInitialized = Shop::Command::init?
    isInitialized.should eq true
  end

  it "should check if the project is initialized" do
    isInitialized = Shop::Command::init?
    isInitialized.should eq true
  end

  it "should return the theme name" do
    theme_name = Shop::Command::theme
    theme_name.should eq "theme_name"
  end
end

describe Shop, "#psVersion" do
  before(:all) do
    FileUtils.mkpath("config")
    File.open("config/settings.inc.php", "w") do |f|
      f.write("<?php\ndefine('_PS_VERSION_', '1.5.5');")
    end
  end

  after(:all) do
    FileUtils.rm_rf("config")
  end

  it "should return the PS version" do
    version = Shop::Command::psVersion
    version.should eq "1.5.5"
  end

  it "should check if PS is installed" do
    isInstalled = Shop::Command::installed?
    isInstalled.should eq true
  end
end

describe Shop, "#makefile" do
  before do
    Shop::Command::init('theme_name')
  end

  after do
    File.delete("#{path}Makefile")
    File.delete("#{path}.shop")
  end

  it "should create a Makefile" do
    Shop::Command::makefile
    File.exists?("#{path}Makefile").should eq true
  end
end
