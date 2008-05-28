#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "rubygems"
require "show_in_github"

url = ShowInGitHub.line_to_github_url(ENV['TM_FILEPATH'], ENV['TM_CURRENT_LINE'])
if url
  `open #{url} -a Safari`
else
  puts "File/project not a git repository or not pushed to a github repository; or an error occurred"
end