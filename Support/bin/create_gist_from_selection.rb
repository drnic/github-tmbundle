#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "rubygems"
require "gist"

selection = nil
if ENV['TM_SELECTED_TEXT']
  selection = ENV['TM_SELECTED_TEXT']
else
  selection = STDIN.read
end

if url = Gist.write(selection, ARGV[0] == "private" ? true : false)
  puts "Created gist at #{url}. URL copied to clipboard."
end