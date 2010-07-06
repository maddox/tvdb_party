require 'rubygems'
require 'httparty'

directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, 'tvdb_party', 'httparty_icebox')
require File.join(directory, 'tvdb_party', 'search')
require File.join(directory, 'tvdb_party', 'series')
require File.join(directory, 'tvdb_party', 'episode')
require File.join(directory, 'tvdb_party', 'banner')
require File.join(directory, 'tvdb_party', 'actor')
