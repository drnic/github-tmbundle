#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "rubygems"
require "git_manager"

begin
  git = GitManager.new(ENV['TM_FILEPATH'])
  url = git.github_url_for_project

  `open #{url}network`
rescue NotGitRepositoryError
  puts "File/project not a git repository"
rescue NotGitHubRepositoryError
  puts "File/project has not been pushed to a github repository"
end