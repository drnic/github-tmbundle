#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "rubygems"
require "show_in_github"

begin
  if url = ShowInGitHub.line_to_github_url(ENV['TM_FILEPATH'], ENV['TM_CURRENT_LINE'])
    `open #{url}`
  else
    puts "This line has been modified or commit has not been pushed to GitHub"
  end
rescue NotGitRepositoryError
  puts "File/project not a git repository"
rescue NotGitHubRepositoryError
  puts "File/project has not been pushed to a github repository"
end