# coding: utf-8

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'fileutils'

require 'shop/command'
require 'shop/color'

module Shop
  VERSION = '0.1.0'
end
