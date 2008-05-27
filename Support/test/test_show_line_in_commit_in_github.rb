require File.dirname(__FILE__) + "/test_helper"
require "show_in_github"

class TestShowLineInCommitInGitHub < Test::Unit::TestCase
  attr_reader :git
  def setup
    @git = GitManager.new __FILE__
    @file = git.relative_file
    puts "These tests require the project to be checked out of git to work" unless @git
  end
  
  def test_find_first_commit_for_this_file
    file_info = @git.git.ls_files[@file]
    sha_index = file_info[:sha_index]
    object = git.git.object(sha_index)
    p object.log.first
    expected = "3becfbcb01574cb4efbcc553ad4be37f6e428e03"
  end
end