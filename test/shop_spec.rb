require 'shop'

describe Shop, '#init' do
  after(:all) { File.delete(".shop") }

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
  it "should return the PS version" do
    version = Shop::Command::psVersion
    version.should eq "1.5.5"
  end
end

describe Shop, "#installed?" do
  it "should check if PS is installed" do
    isInstalled = Shop::Command::installed?
    isInstalled.should eq true
  end
end

describe Shop, "#makefile" do
  before { Shop::Command::init('theme_name')}
  after do
    File.delete("Makefile")
    File.delete(".shop")
  end

  it "should create a Makefile" do
    Shop::Command::makefile
    File.exists?('Makefile').should eq true
  end
end
