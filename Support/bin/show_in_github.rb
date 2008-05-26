#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "show_in_github"

url = ShowInGitHub.url_for(ENV['TM_FILEPATH'])
if url
  `open #{url}#L#{TM_LINE_NUMBER}`
else
  puts "File/project not a git repository or not pushed to a github repository"
end