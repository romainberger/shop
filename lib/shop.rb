# coding: utf-8

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'fileutils'
require 'open-uri'
require 'yaml'

require 'highline/import'

require 'shop/template'
require 'shop/command'
require 'shop/shopconfig'

module Shop
  VERSION = '0.1.4'
end
