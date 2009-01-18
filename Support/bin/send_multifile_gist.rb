#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "gist"

Gist.send(ARGV[0] == "private")
