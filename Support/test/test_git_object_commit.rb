require File.dirname(__FILE__) + "/test_helper"
require "show_in_github"

class TestGitObjectCommit < Test::Unit::TestCase
  attr_reader :git
  def setup
    @git = GitManager.new __FILE__
    puts "These tests require the project to be checked out of git to work" unless @git
  end

  def test_extract_file_paths_from_commit
    mutli_file_commit = "c9e07eb199092fef6a0b744915d49b0aeb646221"
    expected_files = [
      'Support/lib/git_manager.rb',
      'Support/test/test_helper.rb',
      'Support/test/test_show_line_in_commit_in_github.rb'
      ]
    commit = Git::Object::Commit.new(git.git, mutli_file_commit)
    actual_files = commit.file_paths
    assert_equal(expected_files, actual_files)
  end
end