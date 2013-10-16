# coding: utf-8

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'fileutils'
require 'open-uri'
require 'yaml'
require 'mysql2'

require 'highline/import'

require 'shop/template'
require 'shop/color'
require 'shop/command'
require 'shop/platform'
require 'shop/shopconfig'

module Shop
  VERSION = '0.1.9'
end
