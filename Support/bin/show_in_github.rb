#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "rubygems"
require "show_in_github"

begin
  url = ShowInGitHub.url_for(ENV['TM_FILEPATH'])
  lines = ENV['TM_INPUT_START_LINE'] ? "#{ENV['TM_INPUT_START_LINE']}-#{ENV['TM_LINE_NUMBER'].to_i - 1}" : ENV['TM_LINE_NUMBER']
  `open #{url}#L#{lines}`
rescue NotGitRepositoryError
  puts "File/project not a git repository"
rescue NotGitHubRepositoryError
  puts "File/project has not been pushed to a github repository"
end