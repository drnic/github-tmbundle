#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "rubygems"
require "show_in_github"

url = ShowInGitHub.url_for(ENV['TM_FILEPATH'])
if url
  lines = ENV['TM_INPUT_START_LINE'] ? "#{ENV['TM_INPUT_START_LINE']}-#{ENV['TM_LINE_NUMBER'].to_i - 1}" : ENV['TM_LINE_NUMBER']
  `open #{url}#L#{lines}`
else
  puts "File/project not a git repository or not pushed to a github repository"
end